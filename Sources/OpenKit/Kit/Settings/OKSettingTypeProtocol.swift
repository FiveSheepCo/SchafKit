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
import UIKit

/// The protocol for a settings type. This defines the appearance of a setting.
public protocol OKSettingTypeProtocol {
    /// The subtitle to show for the type. This is usually a representation of the value.
    func getSubtitle(for type : OKSettingable.Type, object : OKSettingable?) -> String?
    /// The accessory view to display.
    func getAccessoryView(for type : OKSettingable.Type, object : OKSettingable?) -> UIView?
    /// Whether the disclosure indicator is shown for the setting.
    func getShowsDisclosureIndicator(for type : OKSettingable.Type, object : OKSettingable?) -> Bool
    /// Whether the selection is displayed.
    func getShowsSelection(for type : OKSettingable.Type, object : OKSettingable?) -> Bool
    /// Whether the text color is the action color. This represents the tint color.
    func getTextColorIsActionColor(for type : OKSettingable.Type, object : OKSettingable?) -> Bool
    
    /// The handler called when the setting was selected.
    func didSelect(for type : OKSettingable.Type, object : OKSettingable?, setting : OKSettings.Setting, newValueHandler : @escaping (String, AnyObject?) -> Void)
}
#endif
