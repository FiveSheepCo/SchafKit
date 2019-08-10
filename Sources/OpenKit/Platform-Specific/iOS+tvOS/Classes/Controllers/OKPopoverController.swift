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

private let cornerRadius : CGFloat = 16
private let minimumVerticalSpace : CGFloat = 48
private let minimumHorizontalSpace : CGFloat = 16

/// A controller showing a contained view controller over the current context, but not covering all of the window, in the middle of the window.
///
/// The size of the controller is determined by using the contained view controller's `preferredContentSize`. Maximum size is applied through a minimum spacing.
///
/// - note : It's safe to set the `preferredContentSize` width and/or height to `.greatestFiniteMagnitude` if it should be as wide/high as possible.
public class OKPopoverController : UIViewController, UIGestureRecognizerDelegate, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    public let shownController : UIViewController
    
    /**
     Returns a new `OKPopoverController`.
    
     - parameter viewController : The view controller to contain.
     - parameter inNavigationController : Whether the view controller should be added to a `UINavigationController`. The controller is never added to a `UINavigationController` if it is already one itself. The default value is true.
    */
    public init (viewController : UIViewController, inNavigationController : Bool = true) {
        shownController = (inNavigationController && !(viewController is UINavigationController)) ? UINavigationController(rootViewController: viewController) : viewController
        
        super.init(nibName: nil, bundle: nil)
        
        self.modalPresentationStyle = .overCurrentContext
        self.transitioningDelegate = self
        
        shownController.view.layer.cornerRadius = cornerRadius
        shownController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancel))
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        viewController.addObserver(self, forKeyPath: "preferredContentSize")
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updateFrame()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .clear
        
        updateFrame()
        
        self.addChild(shownController)
        self.view.addSubview(shownController.view)
        shownController.didMove(toParent: self)
    }
    
    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateFrame()
    }
    
    // MARK: - Gesture Recognizer
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !shownController.view.contains(touch)
    }
    
    @objc func cancel() {
        self.dismiss()
    }
    
    internal func setupFrame() {
        self.shownController.view.frame.origin.y = self.view.frame.size.height
    }
    
    internal func updateFrame() {
        var preferredSize = (shownController as? UINavigationController)?.viewControllers.first!.preferredContentSize ?? shownController.preferredContentSize
        
        if preferredSize.height == 0 {
            preferredSize.height = .greatestFiniteMagnitude
        }
        if preferredSize.width == 0 {
            preferredSize.width = .greatestFiniteMagnitude
        }
        
        let preferredHeight = preferredSize.height + ((shownController as? UINavigationController)?.navigationBar.frame.size.height ?? 0)
        let height = min(preferredHeight, self.view.frame.size.height - minimumVerticalSpace * 2)
        
        let preferredWidth = preferredSize.width
        let width = min(preferredWidth, self.view.frame.size.width - minimumHorizontalSpace * 2)
        
        shownController.view.frame = CGRect(x: (self.view.frame.size.width - width) / 2,
                                            y: (self.view.frame.size.height - height) / 2,
                                            width: width,
                                            height: height)
    }
    
    // MARK: - Transitioning Delegate
    
    public func animationController(forPresented presented : UIViewController, presenting : UIViewController, source : UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func animationController(forDismissed dismissed : UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    // MARK: - Animated Transitioning
    
    public func transitionDuration(using transitionContext : UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    public func animateTransition(using transitionContext : UIViewControllerContextTransitioning) {
        let isBeingPresented = transitionContext.viewController(forKey: .to) == self
        
        transitionContext.containerView.addSubview(self.view)
        
        let from : () -> Void = {
            self.setupFrame()
            self.view.backgroundColor = .clear
        }
        let to : () -> Void = {
            self.updateFrame()
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.33)
        }
        
        if isBeingPresented {
            from()
        }
        
        let completion : (Bool) -> Void = { (done) in
            transitionContext.completeTransition(done)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: (isBeingPresented ? to : from), completion: completion)
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .appearance
    }
    
    required public init?(coder aDecoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
