//  Copyright (c) 2015 - 2019 Jann Schafranek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if os(iOS) && canImport(CoreData)
import CoreData

// TODO: Make available on other OS's.

/// A class managing generic settings.
public class OKSettings {
    /// The shared instance.
    public static let shared = OKSettings()
    
    /// The URL to store the database at.
    ///
    /// - note: You can use this to put the database for OKSettings inside an AppGroup.
    /// - important: This has to be set before the shared instance is called for the first time.
    public static var storeDirectoryURL : URL?
    
    // MARK: - Private Functions
    
    private let persistentContainer : NSPersistentContainer = {
        let bundleName = Bundle(for: OKSettings.self).infoDictionary?[String(kCFBundleNameKey)] as! String
        let directory = "Frameworks/\(bundleName).framework"
        
        _ = OKDirectory(url: _OKSettingsPersistantContainer.defaultDirectoryURL().appendingPathComponent(directory, isDirectory: true), createIfNonexistant: true)
        
        let container = _OKSettingsPersistantContainer(name: directory + "/OKSettings")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    private let context : NSManagedObjectContext
    
    private init() {
        context = persistentContainer.viewContext
    }
    
    private func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func getSetting(forKey key : String, type : OKSettingable.Type, uuid : String? = nil) -> SettingStorage? {
        let uuidPredicate : NSPredicate
        if let uuid = uuid {
            uuidPredicate = NSPredicate(format: "uuid == %@", uuid)
        } else {
            uuidPredicate = NSPredicate(format: "uuid == nil")
        }
        let typePredicate = NSPredicate(format: "type == %@", type.settingsTypeIdentifier)
        let keyPredicate = NSPredicate(format: "key == %@", key)
        
        return context.getAllObjects(with: "SettingStorage", predicates: [typePredicate, uuidPredicate, keyPredicate], sortDescriptors: nil, limit: 1).first as? SettingStorage
    }
    
    private func getSetting(forKey key : String, type : OKSettingable.Type, on object : OKSettingable?) -> SettingStorage? {
        return getSetting(forKey: key, type: type, uuid: object?.settingsIdentifier)
    }
    
    private func newSetting(forKey key : String, type : OKSettingable.Type, on object : OKSettingable?) -> SettingStorage {
        let setting = NSEntityDescription.insertNewObject(forEntityName: "Setting", into: context) as! SettingStorage
        
        setting.key = key
        setting.type = type.settingsTypeIdentifier
        setting.uuid = object?.settingsIdentifier
        
        return setting
    }
    
    // MARK: - Private Get and Set
    
    private func getSuper(forKey key : String, type : OKSettingable.Type, object : OKSettingable?) -> AnyObject? {
        if object != nil {
            return get(forKey: key, type: type)
        }
        
        return type.settingsDefaultValues[key]
    }
    
    // MARK: - Private Observe
    
    private var observers : [_OKSettingsObserverStorage] = []
    private func add(observer : OKSettingsObserver, forKey key : String?, type : OKSettingable.Type?, object : OKSettingable?) {
        observers.append(_OKSettingsObserverStorage(observer: observer, key: key, type: type, objectIdentifier: object?.settingsIdentifier))
    }
    
    private func notifyObservers(withValue value : AnyObject?, forKey key : String, type : OKSettingable.Type, object : OKSettingable?) {
        for index in (0..<observers.count).reversed() {
            let storage = observers[index]
            
            guard let observer = storage.observer else {
                observers.remove(at: index)
                continue
            }
            
            let identifier = object?.settingsIdentifier
            
            guard (storage.key ?? key) == key &&
                (storage.type ?? type) == type &&
                (storage.objectIdentifier ?? identifier) == identifier else {
                continue
            }
            
            observer.observe(value: value, forKey: key, type: type, object: object)
        }
    }
    
    // MARK: - Get and Set
    
    /**
     Sets a setting.
    
     - parameters:
         - value : The value to set.
         - key : The key to associate the value with.
         - type : The type to set the value on.
         - object : The object to set the value on.
    */
    public func set(_ value : AnyObject?, forKey key : String, type : OKSettingable.Type, object : OKSettingable?) {
        let value = value as? NSObject
        let superValue = getSuper(forKey: key, type: type, object: object) as? NSObject
        let gottenSetting = getSetting(forKey: key, type: type, on: object)
        
        if value == superValue {
            gottenSetting?.delete()
        } else {
            let setting = gottenSetting ?? newSetting(forKey: key, type: type, on: object)
            
            setting.value = value
        }
        
        save()
        
        notifyObservers(withValue: value, forKey: key, type: type, object: object)
    }
    
    /**
     Sets a setting.
    
     - parameters:
         - value : The value to set.
         - key : The key to associate the value with.
         - type : The type to set the value on.
    */
    public func set(_ value : AnyObject?, forKey key : String, type : OKSettingable.Type) {
        set(value, forKey: key, type: type, object: nil)
    }
    
    /**
     Sets a setting.
    
     - parameters:
         - value : The value to set.
         - key : The key to associate the value with.
         - object : The object to set the value on.
    */
    public func set(_ value : AnyObject?, forKey key : String, object : OKSettingable) {
        set(value, forKey: key, type: type(of: object), object: object)
    }
    
    /**
     Returns a distinct setting, without falling back on the top setting or default value.
    
     - parameters:
         - key : The key the value is associated with.
         - type : The type the value is set on.
         - object : The object the value is set on.
    */
    public func getDistinct(forKey key : String, type : OKSettingable.Type, object : OKSettingable?) -> AnyObject? {
        return getSetting(forKey: key, type: type, on: object)?.value
    }
    
    /**
     Returns a setting, falling back on the top setting or default value if it doesn't exist for the very object.
    
     - parameters:
         - key : The key the value is associated with.
         - type : The type the value is set on.
         - object : The object the value is set on.
    */
    public func get(forKey key : String, type : OKSettingable.Type, object : OKSettingable?) -> AnyObject? {
        return getDistinct(forKey: key, type: type, object: object) ?? getSuper(forKey: key, type: type, object: object)
    }
    
    /**
     Returns a setting, falling back on the default value if it doesn't exist.
    
     - parameters:
         - key : The key the value is associated with.
         - type : The type the value is set on.
    */
    public func get(forKey key : String, type : OKSettingable.Type) -> AnyObject? {
        return get(forKey: key, type: type, object: nil)
    }
    
    /**
     Returns a setting, falling back on the top setting or default value if it doesn't exist for the very object.
    
     - parameters:
         - key : The key the value is associated with.
         - object : The object the value is set on.
    */
    public func get(forKey key : String, object : OKSettingable) -> AnyObject? {
        return get(forKey: key, type: type(of: object), object: object)
    }
    
    // MARK: - Observe
    
    /**
     Adds an observer.
    
     - parameters:
         - observer : The observer.
         - key : The key to observe. If nil, all keys are observed. The default value is nil.
         - type : The type to observe. If nil, all types are observed. The default value is nil.
    */
    public func add(observer : OKSettingsObserver, forKey key : String? = nil, type : OKSettingable.Type? = nil) {
        add(observer: observer, forKey: key, type: type, object: nil)
    }
    
    /**
     Adds an observer.
    
     - parameters:
         - observer : The observer.
         - key : The key to observe. If nil, all keys are observed. The default value is nil.
         - object : The object to observe. If nil, all objects are observed. The default value is nil.
    */
    public func add(observer : OKSettingsObserver, forKey key : String? = nil, object : OKSettingable) {
        add(observer: observer, forKey: key, type: type(of: object), object: object)
    }
}

#endif
