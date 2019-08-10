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
extension OKSettings {
    /// A setting group.
    public struct Group {
        /// The title.
        public let title : String?
        /// The subtitle.
        public let subtitle : String?
        /**
         The getter for the settings.
         
         - note : This is called every time the group is displayed. The `OKSettingable?` is nil when it askes for the settings of the type.
         */
        public let settingsGetter : (OKSettingable?) -> [OKSettings.Setting]
        
        /// Returns a new `OKSettings.Group`.
        public init (title : String? = nil, subtitle : String? = nil, settingsGetter : @escaping (OKSettingable?) -> [OKSettings.Setting]) {
            self.title = title
            self.subtitle = subtitle
            self.settingsGetter = settingsGetter
        }
        
        /// Returns a new `OKSettings.Group` with a static array of settings.
        public init (title : String? = nil, subtitle : String? = nil, settings : [OKSettings.Setting]) {
            self.title = title
            self.subtitle = subtitle
            self.settingsGetter = { (_) -> [OKSettings.Setting] in
                return settings
            }
        }
        
        /// Returns a new `OKSettings.Group` with a static array of settings for the type and a static array of settings for each object.
        public init (title : String? = nil, subtitle : String? = nil, typeSettings : [OKSettings.Setting], objectSettings : [OKSettings.Setting]) {
            self.title = title
            self.subtitle = subtitle
            self.settingsGetter = { (object) -> [OKSettings.Setting] in
                if object == nil {
                    return typeSettings
                }
                return objectSettings
            }
        }
    }
}
#endif
