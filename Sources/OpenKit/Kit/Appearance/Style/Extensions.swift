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

public extension UIColor {
    /// The colors of the current `OKAppearance.Style`.
    struct Appearance {
        /// The primary color, used as the background color.
        static var background : UIColor { return OKAppearance.Style.shared.primaryColor }
        /// The secondary color, used as the foreground color.
        static var foreground : UIColor { return OKAppearance.Style.shared.secondaryColor }
        
        /// The tertiary color, used as a less intrusive foreground color.
        static var tertiary : UIColor { return OKAppearance.Style.shared.tertiaryColor }
        
        /// The absolute color, being the most extreme equivalent of the `primaryColor`.
        static var absolute : UIColor { return OKAppearance.Style.shared.absoluteColor }
        
        /// The separator color, mostly used to seperate areas from each other, e.g. with lines.
        static var separator : UIColor { return OKAppearance.Style.shared.separatorColor }
        
        /// The minimum contrast color, a very unintrusive color near to the `primaryColor`.
        static var minimumContrast : UIColor { return OKAppearance.Style.shared.minimumContrastColor }
        
        /// The maximum contrast color, an intensive color far from the `primaryColor`.
        static var maximumContrast : UIColor { return OKAppearance.Style.shared.maximumContrastColor }
        
        /// The grouped background color, used on the background of `UITableView`s with the `.grouped` style.
        static var tableViewBackground : UIColor { return OKAppearance.Style.shared.tableViewBackgroundColor }
        
        /// The grouped background color, used on the background of `UITableView`s with the `.grouped` style.
        static var tableViewHeaderFooterBackground : UIColor { return OKAppearance.Style.shared.tableViewHeaderFooterBackgroundColor }
        
        /// The table cell selection color, used on the background of `UITableViewCell` when it is selected.
        static var tableCellSelection : UIColor { return OKAppearance.Style.shared.tableCellSelectionColor }
        
        /// The tint color.
        static var tint : UIColor { return OKAppearance.Style.shared.tintColor }
    }
}

public extension UIStatusBarStyle {
    /// The current status bar style.
    static var appearance : UIStatusBarStyle { return OKAppearance.Style.shared.statusBarStyle }
}

public extension UIBarStyle {
    /// The current bar style.
    static var appearance : UIBarStyle { return OKAppearance.Style.shared.barStyle }
}

public extension UIBlurEffect {
    /// The current blur effect.
    static var appearance : UIBlurEffect { return OKAppearance.Style.shared.primaryBlurEffect }
}

public extension UIScrollView.IndicatorStyle {
    /// The current scroll view indicator style.
    static var appearance : UIScrollView.IndicatorStyle { return OKAppearance.Style.shared.scrollIndicatorStyle }
}

public extension UIKeyboardAppearance {
    /// The current keyboard appearance.
    static var appearance : UIKeyboardAppearance { return OKAppearance.Style.shared.keyboardAppearance }
}
#endif
