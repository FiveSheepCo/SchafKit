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

extension OKAppearance {
    /// Describes a style of displaying an applicaiton.
    public struct Style : Equatable {
        /// The currently active style.
        public static var shared : Style { return OKAppearance.shared.style }
        
        /**
         The light style.
         - Note : This resembles the standard iOS style.
         */
        public static var light : Style = Style()
        
        /// The dark style.
        public static var dark : Style =
            Style(isLight: false,
                  primaryColor : UIColor(white: 0.15, alpha: 1),
                  secondaryColor: .white,
                  tertiaryColor: .lightGray,
                  absoluteColor: .black,
                  separatorColor: .darkGray,
                  minimumContrastColor: .darkGray,
                  maximumContrastColor: .lightGray,
                  tableViewBackgroundColor : UIColor(white: 0.1, alpha: 1),
                  tableViewHeaderFooterBackgroundColor : UIColor(white: 0.1, alpha: 1),
                  tableCellSelectionColor : UIColor(white: 0.2, alpha: 1),
                  tintColor: UIColor(red: 0.92, green: 0.6, blue: 0.21),
                  statusBarStyle: .lightContent,
                  barStyle: .black,
                  primaryBlurEffect: UIBlurEffect(style: .dark),
                  scrollIndicatorStyle: .white,
                  keyboardAppearance: .dark,
                  appIconName: nil)
        
        /// The dark style.
        public static var black : Style =
            Style(isLight: false,
                  primaryColor : .black,
                  secondaryColor: .white,
                  tertiaryColor: .lightGray,
                  absoluteColor: .black,
                  separatorColor: .darkGray,
                  minimumContrastColor: .darkGray,
                  maximumContrastColor: .lightGray,
                  tableViewBackgroundColor : .black,
                  tableViewHeaderFooterBackgroundColor : UIColor(white: 0.1),
                  tableCellSelectionColor : UIColor(white: 0.2, alpha: 1),
                  tintColor: UIColor(red: 0.92, green: 0.6, blue: 0.21),
                  statusBarStyle: .lightContent,
                  barStyle: .black,
                  barsAreTranslucent: false,
                  primaryBlurEffect: UIBlurEffect(style: .dark),
                  scrollIndicatorStyle: .white,
                  keyboardAppearance: .dark,
                  appIconName: nil)
        
        /// Whether the style is primarily light.
        public var isLight : Bool
        /// The primary color, used as the background color.
        public var primaryColor : UIColor
        /// The secondary color, used as the foreground color.
        public var secondaryColor : UIColor
        /// The tertiary color, used as a less intrusive foreground color.
        public var tertiaryColor : UIColor
        /// The absolute color, being the most extreme equivalent of the `primaryColor`.
        public var absoluteColor : UIColor
        /// The separator color, mostly used to seperate areas from each other, e.g. with lines.
        public var separatorColor : UIColor
        /// The minimum contrast color, a very unintrusive color near to the `primaryColor`.
        public var minimumContrastColor : UIColor
        /// The maximum contrast color, an intensive color far from the `primaryColor`.
        public var maximumContrastColor : UIColor
        /// The grouped background color, used on the background of `UITableView`s with the `.grouped` style.
        public var tableViewBackgroundColor : UIColor
        /// The grouped background color, used on the background of `UITableView`s with the `.grouped` style.
        public var tableViewHeaderFooterBackgroundColor : UIColor
        /// The table cell selection color, used on the background of `UITableViewCell` when it is selected.
        public var tableCellSelectionColor : UIColor
        
        /// The tint color.
        public var tintColor : UIColor
        
        /// The status bar style.
        public var statusBarStyle : UIStatusBarStyle
        /// Whether bars are translucent.
        public var barsAreTranslucent : Bool
        /// The bar style, used on instances of UINavigationBar, UITabBar, UIToolbar and UISearchBar.
        public var barStyle : UIBarStyle
        /// The primary blur effect, used as a background blur effect.
        public var primaryBlurEffect : UIBlurEffect
        /// The scroll indicator style, used on instances of UIScrollView.
        public var scrollIndicatorStyle : UIScrollView.IndicatorStyle
        /// The keyboard appearance, used on instances of UITextField and UITextView.
        public var keyboardAppearance : UIKeyboardAppearance
        
        /// The name of the alternate icon.
        ///
        /// - note: To set this for the default light and dark theme, call the `set(lightIconName:)` and `set(darkIconName:)`.
        public var appIconName : String?
        
        /// Initializes a new `OKAppearance.Style`.
        init(isLight : Bool = true,
             primaryColor : UIColor = .white,
             secondaryColor : UIColor = .black,
             tertiaryColor : UIColor = .gray,
             absoluteColor : UIColor = .white,
             separatorColor : UIColor = .lightGray,
             minimumContrastColor : UIColor = .lightGray,
             maximumContrastColor : UIColor = .darkGray,
             tableViewBackgroundColor : UIColor = .groupTableViewBackground,
             tableViewHeaderFooterBackgroundColor : UIColor = .groupTableViewBackground,
             tableCellSelectionColor : UIColor = UIColor(white: 0.8, alpha: 1),
             tintColor : UIColor = UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1),
             statusBarStyle : UIStatusBarStyle = .default,
             barStyle : UIBarStyle = .default,
             barsAreTranslucent : Bool = true,
             primaryBlurEffect : UIBlurEffect = UIBlurEffect(style: .light),
             scrollIndicatorStyle : UIScrollView.IndicatorStyle = .default,
             keyboardAppearance : UIKeyboardAppearance = .default,
             appIconName : String? = nil) {
            self.isLight = isLight
            self.primaryColor = primaryColor
            self.secondaryColor = secondaryColor
            self.tertiaryColor = tertiaryColor
            self.absoluteColor = absoluteColor
            self.separatorColor = separatorColor.withAlphaComponent(0.5)
            self.minimumContrastColor = minimumContrastColor
            self.maximumContrastColor = maximumContrastColor
            self.tableViewBackgroundColor = tableViewBackgroundColor
            self.tableViewHeaderFooterBackgroundColor = tableViewHeaderFooterBackgroundColor
            self.tableCellSelectionColor = tableCellSelectionColor
            self.tintColor = tintColor
            self.statusBarStyle = statusBarStyle
            self.barStyle = barStyle
            self.barsAreTranslucent = barsAreTranslucent
            self.primaryBlurEffect = primaryBlurEffect
            self.scrollIndicatorStyle = scrollIndicatorStyle
            self.keyboardAppearance = keyboardAppearance
            self.appIconName = appIconName
        }
    }
}
#endif
