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

import Foundation

#if os(iOS)
public extension OKAppearance {
    /// Describes how the current appearance of the application is determined.
    enum Mode {
        
        /**
         Defines a single style in which the application is always displayed.
         
         - Note : This mode can be changed manually at all times and will take effect.
         */
        case constant (OKAppearance.Style)
        
        /**
         Defines that the observed value will be used as a style.
         
         - Note : If the observed value is nil or not a `OKAppearance.Style`, the `.light` style will be used.
         */
        case keyObserving (object : NSObject, key : String)
        
        /**
         Defines that the observed value is used to determine whether the `.dark` or the `.light` theme is displayed.
         
         - Parameter trueIsDark : If this is true, when the observed value is true, the `.dark` style will be used, when the observed value is false, the `.light` style will be used. If this is false, it is the other way around.
         */
        case booleanKeyObserving (object : NSObject, key : String, trueIsDark : Bool)
        
        // TODO: Do
        case keyValueObserving (object : NSObject, key : String, mapping : [AnyHashable? : OKAppearance.Style])
        
        /**
         Defines that the observed setting is used to determine whether the `.dark` or the `.light` theme is displayed.
         
         - Parameter trueIsDark : If this is true, when the observed value is true, the `.dark` style will be used, when the observed value is false, the `.light` style will be used. If this is false, it is the other way around.
         */
        case settingsBooleanObserving (key : String, type : OKSettingable.Type, trueIsDark : Bool)
        
        /**
         Defines that the observed setting is used to determine whether the `.light`, `.dark` or `.black` theme is displayed.
         
         - Parameter mapping : Describes which value corresponds to which OKAppearance.Style.
         */
        case settingsValueObserving (key : String, type : OKSettingable.Type, mapping : [AnyHashable? : OKAppearance.Style])
        
        // TODO: Do
        public static var standardSettingsValueObserving : Mode {
            return .settingsValueObserving(key: SettingsProxy.Constants.Keys.style,
                                           type: SettingsProxy.self,
                                           mapping: SettingsProxy.Constants.styleMapping)
        }
        
        internal var currentValue : OKAppearance.Style {
            let boolean : Bool?
            let trueIsDark : Bool
            
            switch self {
            case .constant (let style):
                return style
            case .keyObserving (let object, let key):
                return (object.value(forKey: key) as? OKAppearance.Style) ?? .light
            case .booleanKeyObserving (let object, let key, let tID):
                boolean = object.value(forKey: key) as? Bool
                trueIsDark = tID
            case .settingsBooleanObserving(let key, let type, let tID):
                boolean = OKSettings.shared.get(forKey: key, type: type) as? Bool
                trueIsDark = tID
            case .keyValueObserving(let object, let key, let mapping):
                let object = object.value(forKey: key) as? AnyHashable
                return mapping[object] ?? .light
            case .settingsValueObserving(let key, let type, let mapping):
                let object = OKSettings.shared.get(forKey: key, type: type) as? AnyHashable
                return mapping[object] ?? .light
            }
            
            return (boolean != trueIsDark) ? .light : .dark
        }
        
        internal func addObserver(helper : OKAppearance) {
            switch self {
            case .constant(_):
                return
            case .keyObserving(let object, let key):
                object.addObserver(helper, forKeyPath: key)
            case .booleanKeyObserving(let object, let key, _),  .keyValueObserving(let object, let key, _):
                object.addObserver(helper, forKeyPath: key)
            case .settingsBooleanObserving(let key, let type, _), .settingsValueObserving(let key, let type, _):
                OKSettings.shared.add(observer: helper, forKey: key, type: type)
            }
        }
        
        internal func removeObserver(helper : OKAppearance) {
            switch self {
            case .constant(_):
                return
            case .keyObserving(let object, let key):
                object.removeObserver(helper, forKeyPath: key)
            case .booleanKeyObserving(let object, let key, _),  .keyValueObserving(let object, let key, _):
                object.removeObserver(helper, forKeyPath: key)
            case .settingsBooleanObserving(_, _, _), .settingsValueObserving(_, _, _):
                // TODO: Do
                break
            }
        }
    }
}
#endif
