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

#if os(iOS)
import UIKit

extension OKSettings {
    /// A setting.
    public struct Setting {
        /// A list value containing a title and a value.
        public typealias ListValue = (title : String, value : Int)
        
        /// A generic type conforming to the OKSettingTypeProtocol.
        public enum GenericType : OKSettingTypeProtocol {
            /// An setting that has an on and an off state and is reprersented in storage by a boolean value.
            case onOff (key : String)
            
            /// A setting that has multiple list values and is represented in storage by the integer value.
            case listValue(key : String, list : [ListValue])
            
            /**
             Generates a `.listValue` type that contains all values and appends an appendance to their titles.
             
             - parameters:
             - appendance : The appendance to use on all values but 0 and 1.
             - specialZeroPhrase : The title to use on a 0 value. When this is nil, the default appendance is used. The default value is nil.
             - specialSingularAppendance : The appendance to use on a 1 value. When this is nil, the default appendance is used. The default value is nil.
             */
            public static func structuredListValue(key : String, values : [Int], appendance : String = .empty, specialZeroTitle : String? = nil, specialSingularAppendance : String? = nil) -> GenericType {
                let list = values.reduce([ListValue](), { (result, value) -> [ListValue] in
                    var title : String
                    if value == 0, let specialZeroTitle = specialZeroTitle {
                        title = specialZeroTitle
                    } else {
                        title = "\(value) "
                        if value == 1, let specialSingularAppendance = specialSingularAppendance {
                            title += specialSingularAppendance
                        } else {
                            title += appendance
                        }
                    }
                    
                    return result + [(title: title, value: value)]
                })
                return .listValue(key: key, list: list)
            }
            
            /// A setting made for showing a view controller when selected. The showing is outsourced to the `showHandler`, making it possible to execute arbitrary code.
            case subViewController(showHandler : () -> Void)
            /// A setting made for performing an action when selected.
            case action(handler:() -> Void)
            
            /// A setting showing a subpage when selected.
            case subPage(OKSettings.Page)
            /// A setting showing a the main page of a Settingable when selected.
            case subSettingable(OKSettingable.Type)
            
            /// A setting showing an information, without an action.
            case information(getter : (OKSettingable?) -> String)
            
            
            public func getSubtitle(for type : OKSettingable.Type, object : OKSettingable?) -> String? {
                switch self {
                case .information(let getter):
                    return getter(object)
                case .listValue(let key , let list):
                    for item in list where item.value == OKSettings.shared.get(forKey: key, type: type, object: object) as? Int {
                        return item.title
                    }
                    return nil
                default:
                    return nil
                }
            }
            
            public func getAccessoryView(for type : OKSettingable.Type, object : OKSettingable?) -> UIView? {
                switch self {
                case .onOff(let key):
                    return OKSettingsSwitch(key: key, type: type, object: object)
                default:
                    return nil
                }
            }
            
            public func getShowsDisclosureIndicator(for type : OKSettingable.Type, object : OKSettingable?) -> Bool {
                switch self {
                case .listValue, .subPage, .subSettingable, .subViewController:
                    return true
                default:
                    return false
                }
            }
            
            public func getShowsSelection(for type : OKSettingable.Type, object : OKSettingable?) -> Bool {
                switch self {
                case .action, .listValue, .subPage, .subSettingable, .subViewController:
                    return true
                default:
                    return false
                }
            }
            
            public func getTextColorIsActionColor(for type : OKSettingable.Type, object : OKSettingable?) -> Bool {
                switch self {
                case .action:
                    return true
                default:
                    return false
                }
            }
            
            public func didSelect(for type : OKSettingable.Type, object : OKSettingable?, setting : OKSettings.Setting, newValueHandler : @escaping (String, AnyObject?) -> Void) {
                let viewController : UIViewController?
                
                switch self {
                case .action(let handler):
                    handler()
                    return
                case .listValue(let key, let list):
                    viewController = _OKListValueChooserViewController(title: setting.title, listValues: list, currentValue : OKSettings.shared.get(forKey: key, type: type, object: object) as? Int, newValueHandler: { (newValue) in
                        newValueHandler(key, newValue as AnyObject)
                    })
                case .subPage(let page):
                    viewController = OKSettingsController(page: page, type: type, object: object)
                case .subSettingable(let settingable):
                    viewController = OKSettingsController(type: settingable)
                default:
                    return
                }
                
                #if !EXTENSION
                viewController?.show(type: .push)
                #endif
            }
        }
        
        /// An image to display for a setting.
        public enum Image {
            /// A symbol with an image and a background color, displaying as a round rect of the background color with the image on it.
            public struct Symbol {
                let image : UIImage
                let backgroundColor : UIColor
            }
            
            /// A plain image.
            case plain (UIImage)
            /// Displays a given symbol.
            case symbol (Symbol)
            
            internal func getRaw(standardSize : CGFloat) -> UIImage {
                switch self {
                case .plain(let image):
                    return image
                case .symbol(let symbol):
                    let size = CGSize(width: standardSize, height: standardSize)
                    UIGraphicsBeginImageContextWithOptions(size, false, 0)
                    
                    symbol.backgroundColor.setFill()
                    let path = UIBezierPath(roundedRect : CGRect(origin: .zero, size: size), cornerRadius: standardSize * 0.25)
                    path.fill()
                    
                    let image = symbol.image
                    let imageToDraw = (image.renderingMode == .alwaysOriginal) ? image : image.tintedImage(OKAppearance.Style.shared.primaryColor)
                    imageToDraw.draw(at : CGPoint(x: (standardSize - image.size.width) / 2, y: (standardSize - image.size.height) / 2))
                    
                    let returnImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    return returnImage!
                }
            }
        }
        
        /// The type.
        public let type : OKSettingTypeProtocol
        /// The title.
        public let title : String
        /// The image.
        public let image : Image?
        
        /// Returns a new OKSettings.Setting.
        public init (type : GenericType, title : String, image : Image? = nil) {
            self.init(typeProtocol: type, title: title, image: image)
        }
        
        /// Returns a new OKSettings.Setting.
        public init (typeProtocol : OKSettingTypeProtocol, title : String, image : Image? = nil) {
            self.type = typeProtocol
            self.title = title
            self.image = image
        }
    }
}
#endif
