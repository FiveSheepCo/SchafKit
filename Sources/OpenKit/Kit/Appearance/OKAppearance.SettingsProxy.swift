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
    /// A proxy to add OKAppearance settings to OKSettings.
    class SettingsProxy : OKSettingable {
        struct Constants {
            struct Keys {
                static let style = "style"
            }
            
            struct Names {
                static let appearance = "Appearance".localized
                static let style = "Style".localized
            }
            
            static let appearanceSettingType = OKSettings.Setting.GenericType.listValue(key: Keys.style,
                                                                               list: [("Light".localized, 0),
                                                                                      ("Dark".localized, 1),
                                                                                      ("Black".localized, 2)])
            
            static let styleMapping : [Int : OKAppearance.Style] = [
                0: .light,
                1: .dark,
                2: .black
            ]
        }
        
        public static var settingsTypeIdentifier: String {
            return "OKAppearanceSettingProxy"
        }
        
        public static var settingsMainPage: OKSettings.Page {
            return OKSettings.Page(title: Constants.Names.appearance, groups: [
                OKSettings.Group(title: .empty, settings: [
                    OKSettings.Setting(type: Constants.appearanceSettingType, title: Constants.Names.style)
                    ])
                ])
        }
        
        public static let setting = OKSettings.Setting(type: OKSettings.Setting.GenericType.subSettingable(SettingsProxy.self), title: Constants.Names.appearance)
        
        private static var defaultStyleKey : Int = 0
        public static func setDefaultStyleKey(_ key : Int) {
            defaultStyleKey = key
        }
        
        public static var settingsDefaultValues: [String : AnyObject] {
            return [Constants.Keys.style: defaultStyleKey as AnyObject]
        }
        
        public var settingsIdentifier: String {
            return .empty
        }
    }
}
#endif
