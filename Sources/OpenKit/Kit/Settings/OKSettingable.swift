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

/// A protocol for classes that offer settings.
public protocol OKSettingable {
    /// An idenfifier for the class.
    static var settingsTypeIdentifier : String {get}
    /// The main page of settings.
    static var settingsMainPage : OKSettings.Page {get}
    /// The default values to fall back on when no setting is set.
    static var settingsDefaultValues : [String : AnyObject] {get}
    
    /// An idenfifier for the object.
    var settingsIdentifier : String {get}
}

public extension OKSettingable {
    
    static var settingsDefaultValues : [String : AnyObject] {
        return [:]
    }
    
    var settingsIdentifier : String {
        return .empty
    }
    
    /**
     Sets a setting.
     
     - parameters:
     - value : The value to set.
     - key : The key to associate the value with.
     - object : The object to set the value on. If this is nil, it sets the value on the type. The default value is nil.
     */
    static func setSetting(_ value : AnyObject?, forKey key : String, on object : Self? = nil) {
        if let object = object {
            OKSettings.shared.set(value, forKey: key, object: object)
            return
        }
        
        OKSettings.shared.set(value, forKey: key, type: self)
    }
    
    /**
     Returns a setting, falling back on the top setting or default value if it doesn't exist for the very object.
     
     - parameters:
     - key : The key the value is associated with.
     - object : The object the value is set on. If this is nil, it gets the value on the type. The default value is nil.
     */
    static func getSetting(forKey key : String, on object : Self? = nil) -> AnyObject? {
        if let object = object {
            return OKSettings.shared.get(forKey: key, object: object)
        }
        
        return OKSettings.shared.get(forKey: key, type: self)
    }
    
    /**
     Sets a setting.
     
     - parameters:
     - value : The value to set.
     - key : The key to associate the value with.
     */
    func setSetting(_ value : AnyObject?, forKey key : String) {
        OKSettings.shared.set(value, forKey: key, object: self)
    }
    
    /**
     Returns a setting, falling back on the top setting or default value if it doesn't exist for the very object.
     
     - parameters:
     - key : The key the value is associated with.
     */
    func getSetting(forKey key : String) -> AnyObject? {
        return OKSettings.shared.get(forKey: key, object: self)
    }
}
#endif
