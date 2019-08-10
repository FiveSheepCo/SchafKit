//
//  NSPersistantContainer.swift
//  JSKit
//
//  Created by Jann Schafranek on 11.09.18.
//  Copyright © 2018 Jann Schafranek. All rights reserved.
//

import Foundation
import CoreData

// An instance of NSPersistentContainer includes all objects needed to represent a functioning Core Data stack, and provides convenience methods and properties for common patterns.
open class INSPersistentContainer {
    open class func defaultDirectoryURL() -> URL {
        struct Static {
            static let instance: URL = {
                guard let applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
                    fatalError("Found no possible URLs for directory type \(FileManager.SearchPathDirectory.applicationSupportDirectory)")
                }
                
                var isDirectory = ObjCBool(false)
                if !FileManager.default.fileExists(atPath: applicationSupportURL.path, isDirectory: &isDirectory) {
                    do {
                        try FileManager.default.createDirectory(at: applicationSupportURL, withIntermediateDirectories: true, attributes: nil)
                        return applicationSupportURL
                    } catch {
                        fatalError("Failed to create directory \(applicationSupportURL)")
                    }
                }
                return applicationSupportURL
            }()
        }
        return Static.instance
    }
    
    open private(set) var name: String
    open private(set) var viewContext: NSManagedObjectContext
    open var managedObjectModel: NSManagedObjectModel {
        return persistentStoreCoordinator.managedObjectModel
    }
    open private(set) var persistentStoreCoordinator: NSPersistentStoreCoordinator
    open var persistentStoreDescriptions: [INSPersistentStoreDescription]
    
    public convenience init(name: String) {
        if let modelURL = Bundle.main.url(forResource: name, withExtension: "mom") ?? Bundle.main.url(forResource: name, withExtension: "momd") {
            if let model = NSManagedObjectModel(contentsOf: modelURL) {
                self.init(name: name, managedObjectModel: model)
                return
            }
            print("CoreData: Failed to load model at path: \(modelURL)")
        }
        guard let model = NSManagedObjectModel.mergedModel(from: [Bundle.main]) else {
            fatalError("Couldn't find managed object model in main bundle.")
        }
        self.init(name: name, managedObjectModel: model)
    }
    
    public init(name: String, managedObjectModel model: NSManagedObjectModel) {
        self.name = name
        self.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        self.viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        self.viewContext.persistentStoreCoordinator = persistentStoreCoordinator
        self.persistentStoreDescriptions = [INSPersistentStoreDescription(url: type(of: self).defaultDirectoryURL().appendingPathComponent("\(name).sqlite"))]
    }
    
    // Load stores from the storeDescriptions property that have not already been successfully added to the container. The completion handler is called once for each store that succeeds or fails.
    open func loadPersistentStores(completionHandler block: @escaping (INSPersistentStoreDescription, Error?) -> Swift.Void) {
        for persistentStoreDescription in persistentStoreDescriptions {
            persistentStoreCoordinator.ins_addPersistentStore(with: persistentStoreDescription, completionHandler: block)
        }
    }
    
    open func newBackgroundContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        if let parentContext = viewContext.parent {
            context.parent = parentContext
        } else {
            context.persistentStoreCoordinator = persistentStoreCoordinator
        }
        return context
    }
    
    open func performBackgroundTask(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let context = newBackgroundContext()
        context.perform {
            block(context)
        }
    }
}

open class INSPersistentStoreDescription: CustomStringConvertible {
    open var type: String = "SQLite"
    open var configuration: String?
    
    open var url: Foundation.URL
    open private(set) var options: [String : Any] = [:]
    
    open var sqlitePragmas: [String : Any] {
        return options[NSSQLitePragmasOption] as? [String : Any] ?? [:]
    }
    
    open var description: String {
        return "type: \(type), url: \(url)"
    }
    
    // addPersistentStore-time behaviours
    open var shouldAddStoreAsynchronously: Bool {
        set {
            options["NSAddStoreAsynchronouslyOption"] = newValue
        }
        get {
            return options["NSAddStoreAsynchronouslyOption"] as? Bool ?? false
        }
    }
    open var shouldMigrateStoreAutomatically: Bool {
        set {
            options[NSMigratePersistentStoresAutomaticallyOption] = newValue
        }
        get {
            return options[NSMigratePersistentStoresAutomaticallyOption] as? Bool ?? false
        }
    }
    open var shouldInferMappingModelAutomatically: Bool {
        set {
            options[NSInferMappingModelAutomaticallyOption] = newValue
        }
        get {
            return options[NSInferMappingModelAutomaticallyOption] as? Bool ?? false
        }
    }
    
    // Store options
    open var isReadOnly: Bool {
        set {
            options[NSReadOnlyPersistentStoreOption] = newValue
        }
        get {
            return options[NSReadOnlyPersistentStoreOption] as? Bool ?? false
        }
    }
    open var timeout: TimeInterval {
        set {
            options[NSPersistentStoreTimeoutOption] = newValue
        }
        get {
            return options[NSPersistentStoreTimeoutOption] as? TimeInterval ?? 0
        }
    }
    
    // Returns a store description instance with default values for the store located at `URL` that can be used immediately with `addPersistentStoreWithDescription:completionHandler:`.
    public init(url: Foundation.URL) {
        self.url = (url as NSURL).copy() as! Foundation.URL
        self.shouldMigrateStoreAutomatically = true
        self.shouldInferMappingModelAutomatically = true
    }
    
    open func setValue(_ value: NSObject?, forPragmaNamed name: String) {
        var pragmas = sqlitePragmas
        if let value = value {
            pragmas[name] = value
        } else {
            pragmas.removeValue(forKey: name)
        }
        setOption(pragmas as NSObject?, forKey: NSSQLitePragmasOption)
    }
    
    open func setOption(_ option: NSObject?, forKey key: String) {
        var options = self.options
        if let option = option {
            options[key] = option
        } else {
            options.removeValue(forKey: key)
        }
    }
}

extension NSPersistentStoreCoordinator {
    open func ins_addPersistentStore(with storeDescription: INSPersistentStoreDescription, completionHandler block: @escaping (INSPersistentStoreDescription, Error?) -> Swift.Void) {
        if storeDescription.shouldAddStoreAsynchronously {
            DispatchQueue.global(qos: .background).async(execute: {
                do {
                    try self.addPersistentStore(ofType: storeDescription.type, configurationName: storeDescription.configuration, at: storeDescription.url, options: storeDescription.options)
                    block(storeDescription, nil)
                } catch let error as NSError {
                    block(storeDescription, error)
                }
            })
        } else {
            do {
                try self.addPersistentStore(ofType: storeDescription.type, configurationName: storeDescription.configuration, at: storeDescription.url, options: storeDescription.options)
                block(storeDescription, nil)
            } catch let error as NSError {
                block(storeDescription, error)
            }
        }
    }
}


extension NSManagedObjectContext {
    private struct AssociatedKeys {
        static var MergesChangesFromParent: String = "ins_automaticallyMergesChangesFromParent"
        static var ObtainPermamentIDsForInsertedObjects: String = "ins_automaticallyObtainPermanentIDsForInsertedObjects"
        static var NotificationQueue: String = "ins_notificationQueue"
    }
    
    private var notificationQueue: DispatchQueue {
        guard let notificationQueue = objc_getAssociatedObject(self, &AssociatedKeys.NotificationQueue) as? DispatchQueue else {
            let queue = DispatchQueue(label: "io.inspace.managedobjectcontext.notificationqueue")
            objc_setAssociatedObject(self, &AssociatedKeys.ObtainPermamentIDsForInsertedObjects, queue, .OBJC_ASSOCIATION_RETAIN)
            return queue
        }
        return notificationQueue
    }
    
    private var _ins_automaticallyObtainPermanentIDsForInsertedObjects: Bool {
        return objc_getAssociatedObject(self, &AssociatedKeys.ObtainPermamentIDsForInsertedObjects) as? Bool ?? false
    }
    
    var ins_automaticallyObtainPermanentIDsForInsertedObjects: Bool {
        set {
            notificationQueue.sync {
                if newValue != self._ins_automaticallyObtainPermanentIDsForInsertedObjects {
                    objc_setAssociatedObject(self, &AssociatedKeys.ObtainPermamentIDsForInsertedObjects, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    if newValue {
                        NotificationCenter.default.addObserver(self, selector: #selector(NSManagedObjectContext.ins_automaticallyObtainPermanentIDsForInsertedObjectsFromWillSaveNotification(_:)), name: NSNotification.Name.NSManagedObjectContextWillSave, object: self)
                    } else {
                        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSManagedObjectContextWillSave, object: self)
                    }
                }
            }
        }
        get {
            var value = false
            notificationQueue.sync {
                value = self._ins_automaticallyObtainPermanentIDsForInsertedObjects
            }
            return value
        }
    }
    
    private var _ins_automaticallyMergesChangesFromParent: Bool {
        return objc_getAssociatedObject(self, &AssociatedKeys.MergesChangesFromParent) as? Bool ?? false
    }
    
    var ins_automaticallyMergesChangesFromParent: Bool {
        set {
            if concurrencyType == NSManagedObjectContextConcurrencyType(rawValue: 0)/* .ConfinementConcurrencyType */ {
                fatalError("Automatic merging is not supported by contexts using NSConfinementConcurrencyType")
            }
            if parent == nil && persistentStoreCoordinator == nil {
                fatalError("Cannot enable automatic merging for a context without a parent, set a parent context or persistent store coordinator first.")
            }
            notificationQueue.sync {
                if newValue != self._ins_automaticallyMergesChangesFromParent {
                    objc_setAssociatedObject(self, &AssociatedKeys.MergesChangesFromParent, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                    if newValue {
                        NotificationCenter.default.addObserver(self, selector: #selector(NSManagedObjectContext.ins_automaticallyMergeChangesFromContextDidSaveNotification(_:)), name: NSNotification.Name.NSManagedObjectContextDidSave, object: self.parent)
                    } else {
                        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NSManagedObjectContextDidSave, object: self.parent)
                    }
                }
            }
        }
        get {
            if concurrencyType == NSManagedObjectContextConcurrencyType(rawValue: 0)/* .ConfinementConcurrencyType */ {
                return false
            }
            var value = false
            notificationQueue.sync {
                value = self._ins_automaticallyMergesChangesFromParent
            }
            return value
        }
    }
    
    @objc private func ins_automaticallyMergeChangesFromContextDidSaveNotification(_ notification: Notification) {
        guard let context = notification.object as? NSManagedObjectContext, let persistentStoreCoordinator = persistentStoreCoordinator, let contextCoordinator = context.persistentStoreCoordinator , persistentStoreCoordinator == contextCoordinator else {
            return
        }
        let isRootContext = context.parent == nil
        let isParentContext = parent == context
        guard (isRootContext || isParentContext) && context != self else {
            return
        }
        perform {
            // WORKAROUND FOR: http://stackoverflow.com/questions/3923826/nsfetchedresultscontroller-with-predicate-ignores-changes-merged-from-different/3927811#3927811
            if let updatedObjects = (notification as NSNotification).userInfo?[NSUpdatedObjectsKey] as? Set<NSManagedObject> , !updatedObjects.isEmpty {
                for updatedObject in updatedObjects {
                    self.object(with: updatedObject.objectID).willAccessValue(forKey: nil) // ensures that a fault has been fired
                }
            }
            
            self.mergeChanges(fromContextDidSave: notification)
        }
    }
    
    @objc private func ins_automaticallyObtainPermanentIDsForInsertedObjectsFromWillSaveNotification(_ notification: Notification) {
        guard let context = notification.object as? NSManagedObjectContext , context.insertedObjects.count > 0 else {
            return
        }
        context.perform {
            _ = try? context.obtainPermanentIDs(for: Array(context.insertedObjects))
        }
    }
}

class INSDataStackContainer: INSPersistentContainer {
    fileprivate class INSDataStackContainerManagedObjectContext: NSManagedObjectContext {
        deinit {
            self.ins_automaticallyObtainPermanentIDsForInsertedObjects = false
            
            guard #available(iOS 10.0, OSX 10.12, *) else {
                self.ins_automaticallyMergesChangesFromParent = false
                return
            }
        }
    }
    
    override init(name: String, managedObjectModel model: NSManagedObjectModel) {
        super.init(name: name, managedObjectModel: model)
        if #available(iOS 10.0, OSX 10.12, *) {
            viewContext.automaticallyMergesChangesFromParent = true
        } else {
            viewContext.ins_automaticallyMergesChangesFromParent = true
        }
    }
    
    override func newBackgroundContext() -> NSManagedObjectContext {
        let context = INSDataStackContainerManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        if let parentContext = viewContext.parent {
            context.parent = parentContext
        } else {
            context.persistentStoreCoordinator = persistentStoreCoordinator
        }
        context.ins_automaticallyObtainPermanentIDsForInsertedObjects = true
        return context
    }
}
