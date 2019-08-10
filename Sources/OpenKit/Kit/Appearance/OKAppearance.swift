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

/// Describes and manages how the application is displayed. Manages both the current `OKAppearance.Style` and the current fonts and their sizes.
public class OKAppearance : NSObject, OKSettingsObserver {
    /// Returns the singleton helper instance.
    public static let shared : OKAppearance = OKAppearance()
    
    /// The notification that is posted when the standard fonts changes.
    public static let fontChangeNotification = Notification.Name("OKFontChangeNotification")
    /// The notification that is posted when the standard style changes.
    public static let styleChangeNotification = Notification.Name("OKStyleChangeNotification")
    
    /// The current style.
    public var style : Style!
    
    /// The current standard font size.
    public var standardFontSize : CGFloat!
    /// The current standard title font.
    public var titleFont : UIFont!
    /// The current standard minimal title font.
    public var minimalTitleFont : UIFont!
    /// The current standard footnote font.
    public var footnoteFont : UIFont!
    /// The current standard subhead font.
    public var subheadFont : UIFont!
    
    /// The current `OKAppearance.Mode`.
    public var mode : Mode = .constant(.light){
        willSet {
            mode.removeObserver(helper: self)
        }
        didSet {
            updateStyle()
            mode.addObserver(helper: self)
        }
    }
    
    /// The application windows, if they are available.
    private var applicationWindows : [UIWindow] {
        #if EXTENSION
        return []
        #else
        return UIApplication.shared.windows
        #endif
    }
    
    private override init() {
        super.init()
        
        self.updateStyle()
        self.updateSize()
        
        NotificationCenter.default.addObserver(self, selector: #selector(OKAppearance.observeSize), name : UIContentSizeCategory.didChangeNotification, object: nil)
        
        #if os(iOS)
        UITableViewCell.appearance().selectedBackgroundView = OKAppearance.TableViewCellBackgroundView()
        UITableViewCell.appearance().multipleSelectionBackgroundView = OKAppearance.TableViewCellBackgroundView()
        #endif
    }
    
    override public func observeValue(forKeyPath keyPath : String?,
                                      of object : Any?,
                                      change: [NSKeyValueChangeKey : Any]?,
                                      context : UnsafeMutableRawPointer?) {
        updateStyle()
    }
    
    internal func updateStyle() {
        let style = mode.currentValue
        
        if let currentStyle = self.style, currentStyle == style {
            return
        }
        
        self.style = style
        
        for window in applicationWindows {
            window.tintColor = style.tintColor
        }
        
        #if os(iOS)
        UITabBar.appearance().barStyle = style.barStyle
        UIToolbar.appearance().barStyle = style.barStyle
        UISearchBar.appearance().barStyle = style.barStyle
        UINavigationBar.appearance().barStyle = style.barStyle
        
        UITabBar.appearance().isTranslucent = style.barsAreTranslucent
        UIToolbar.appearance().isTranslucent = style.barsAreTranslucent
        UISearchBar.appearance().isTranslucent = style.barsAreTranslucent
        UINavigationBar.appearance().isTranslucent = style.barsAreTranslucent
        
        UITableView.appearance().separatorColor = style.separatorColor
        
        if #available(iOS 9.0, *) {
            UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).textColor = style.maximumContrastColor
            UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).backgroundColor = .clear
            
            UIView.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).backgroundColor = style.tableViewHeaderFooterBackgroundColor
        }
        
        UIRefreshControl.appearance().tintColor = style.secondaryColor
        #endif
        
        UITableView.appearance().backgroundColor = style.primaryColor
        UITableViewCell.appearance().backgroundColor = style.primaryColor
        
        UILabel.appearance().textColor = style.secondaryColor
        UITextView.appearance().textColor = style.secondaryColor
        UITextField.appearance().textColor = style.secondaryColor
        
        UIScrollView.appearance().indicatorStyle = style.scrollIndicatorStyle
        
        // TODO: Uncomment following line when crash bug is fixed. That bug crashes any app that has UITextViews in it's view hierarchy before the keyboardAppearance is set on the appearance(). Another way to fix this might be to remove all views from the view hierarchy before and add them after executung this (split `resetViews`)
        // UITextView.appearance().keyboardAppearance = style.keyboardAppearance
        UITextField.appearance().keyboardAppearance = style.keyboardAppearance
        
        reloadIcon()
        
        resetViews()
        _OKStyleHelper.shared.updateAll(with: style)
        NotificationCenter.default.post(name : OKAppearance.styleChangeNotification, object: nil)
    }
    
    @objc func observeSize(){
        self.updateSize()
        NotificationCenter.default.post(name : OKAppearance.fontChangeNotification, object: nil)
    }
    
    // TODO: Change
    private func updateSize(){
        standardFontSize = UIFont.preferredFont(forTextStyle : UIFont.TextStyle.body).pointSize
        let headlineSize = UIFont.preferredFont(forTextStyle : UIFont.TextStyle.headline).pointSize
        let footnoteSize = UIFont.preferredFont(forTextStyle : UIFont.TextStyle.footnote).pointSize
        let subheadSize = UIFont.preferredFont(forTextStyle : UIFont.TextStyle.subheadline).pointSize
        
        titleFont = UIFont.boldSystemFont(ofSize: headlineSize)
        minimalTitleFont = UIFont.systemFont(ofSize: standardFontSize)
        footnoteFont = UIFont.systemFont(ofSize: footnoteSize)
        subheadFont = UIFont.systemFont(ofSize: subheadSize)
    }
    
    private func resetViews() {
        for window in applicationWindows {
            let subviews = window.subviews as [UIView]
            for v in subviews {
                v.removeFromSuperview()
                window.addSubview(v)
            }
        }
    }
    
    // - MARK: Set Alternate Icons
    
    private func reloadIcon() {
        #if !EXTENSION
        if #available(iOS 10.3, *) {
            let iconName : String? = style.appIconName
            
            let app = UIApplication.shared
            if iconName != app.alternateIconName && app.supportsAlternateIcons {
                app.setAlternateIconName(iconName, completionHandler: nil)
            }
        }
        #endif
    }
    
    // - MARK: Observe Settings Value
    
    public func observe(value: AnyObject?, forKey key: String, type: OKSettingable.Type, object: OKSettingable?) {
        updateStyle()
    }
}
#endif
