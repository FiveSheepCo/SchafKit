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

private let cancelButtonHeight : CGFloat = 56
private let cancelButtonCornerRadius : CGFloat = 16

/// A controller showing a contained view controller over the current context, but not covering all of the window, in the bottom of the window.
///
/// The size of the controller is determined by using the contained view controller's `preferredContentSize`. Maximum size is applied through a minimum spacing.
///
/// - note : It's safe to set the `preferredContentSize` width and/or height to `.greatestFiniteMagnitude` if it should be as wide/high as possible.
public class OKBottomSheetPopoverController : OKPopoverController {
    private let button = UIButton(type: .system)
    
    override private init(viewController: UIViewController, inNavigationController: Bool) {
        fatalError("Not supported on OKBottomSheetPopoverController.")
    }
    
    public init(viewController: UIViewController) {
        super.init(viewController: viewController, inNavigationController: false)
        
        self.view.addSubview(button)
        button.setTitle("Cancel".localized)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = cancelButtonCornerRadius
        button.backgroundColor = OKAppearance.Style.shared.primaryColor.withAlphaComponent(0.95)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupFrame() {
        super.setupFrame()
        
        button.frame.origin.y = shownController.view.frame.origin.y + shownController.view.frame.size.height + systemSpacing
    }
    
    override func updateFrame() {
        var preferredSize = (shownController as? UINavigationController)?.viewControllers.first!.preferredContentSize ?? shownController.preferredContentSize
        
        if preferredSize.height == 0 {
            preferredSize.height = .greatestFiniteMagnitude
        }
        
        let cancelButtonY = self.view.frame.size.height - (doubleSystemSpacing + cancelButtonHeight)
        let width = self.view.frame.size.width - 2 * doubleSystemSpacing
        
        button.frame = CGRect(x: doubleSystemSpacing,
                              y: cancelButtonY,
                              width: width,
                              height: cancelButtonHeight)
        
        let preferredHeight = preferredSize.height + ((shownController as? UINavigationController)?.navigationBar.frame.size.height ?? 0)
        let bottomHeight = doubleSystemSpacing + systemSpacing + cancelButtonHeight
        let height = min(preferredHeight, self.view.frame.size.height - bottomHeight - systemSpacing)
        let y = self.view.frame.size.height - (bottomHeight + height)
        
        shownController.view.frame = CGRect(x: doubleSystemSpacing,
                                            y: y,
                                            width: width,
                                            height: height)
    }
}
#endif
