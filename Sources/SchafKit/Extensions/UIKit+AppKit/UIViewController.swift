//  Copyright (c) 2020 Quintschaf GbR
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

#if os(iOS) || os(tvOS)
import UIKit

public extension UIViewController {
    
    /// Defines how a `UIViewController` is shown.
    enum ShowingStyle {
        /// Presents the `UIViewController`.
        case present
        /// Pushes the `UIViewController` onto the current navigation stack.
        case push
    }
    
    #if os(iOS)
    
    /// The topmost `UIViewController` in this controllers hierarchy.
    var topmostViewController : UIViewController {
        let controller : UIViewController
        
        if let presentedViewController = presentedViewController {
            controller = presentedViewController
        } else if let split = self as? UISplitViewController {
            controller = split.viewControllers.last ?? split
        } else if let navigationController = self as? UINavigationController {
            controller = navigationController.viewControllers.last ?? navigationController
        } else if let tabBarController = self as? UITabBarController {
            controller = tabBarController.selectedViewController ?? tabBarController
        } else {
            let visible = self.navigationController?.visibleViewController
            if visible == self || visible == self.navigationController || visible == self.tabBarController {
                return self
            } else {
                return visible?.topmostViewController ?? self
            }
        }
        
        return (controller == self) ? self : controller.topmostViewController
    }
    
    /// An enum representing possible containers of UIViewControllers.
    enum Container {
        case navigationController
        
        /*static var popoverController : Container {
            return .popoverController(inNavigationController: true)
        }*/
        
        func get(for controller : UIViewController) -> UIViewController {
            switch self {
            case .navigationController:
                return UINavigationController(rootViewController: controller)
            }
        }
    }
    
    #endif
    
    #if os(tvOS)
    
    /// The topmost `UIViewController` in this controllers hierarchy.
    var topmostViewController : UIViewController {
        let controller : UIViewController
        
        if let presentedViewController = presentedViewController {
            controller = presentedViewController
        } else if let split = self as? UISplitViewController {
            controller = split.viewControllers.last ?? split
        } else if let navigationController = self as? UINavigationController {
            controller = navigationController.viewControllers.last ?? navigationController
        } else if let tabBarController = self as? UITabBarController {
            controller = tabBarController.selectedViewController ?? tabBarController
        } else {
            let visible = self.navigationController?.visibleViewController
            return ((visible != self) ? visible : nil)?.topmostViewController ?? self
        }
        
        return (controller == self) ? self : controller.topmostViewController
    }
    
    /// An enum representing possible containers of UIViewControllers.
    enum Container {
        case navigationController
        
        func get(for controller : UIViewController) -> UIViewController {
            switch self {
            case .navigationController:
                return UINavigationController(rootViewController: controller)
            }
        }
    }

    #endif
    
    // Do not load these in the extension target
    #if !EXTENSION
    
    /// A type representing methods of showing a UIViewController.
    enum ShowType {
        case present
        case push
    }
    
    /// Shows the responder.
    @available(iOSApplicationExtension, unavailable)
    func show(in container : Container? = nil, type : ShowType) {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        let actualController = container?.get(for: self) ?? self
        
        switch type {
        case .push:
            rootViewController.topmostViewController.navigationController?.pushViewController(actualController, animated: true)
        case .present:
            rootViewController._present(actualController)
        }
    }
    
    /// Shows the responder modally.
    @available(iOSApplicationExtension, unavailable)
    func show(in container : Container? = nil) {
        show(in: container, type: .present)
    }
    
    private func _present(_ viewController : UIViewController) {
        guard let presentedViewController = presentedViewController else {
            self.present(viewController)
            return
        }
        presentedViewController._present(viewController)
    }
    
    #endif
    
    /// Presents a view controller animatedly.
    func present(_ viewController : UIViewController){
        present(viewController, animated: true, completion: nil)
    }
    
    /**
     Presents the responder inside a `UINavigationController`.
    
     - Parameters:
       - animated : Whether to animate the presentation.
       - addingDoneButton : Whether to add a `UIBarButtonItem` with `UIBarButtonSystemItem.done` to the `rightBarButtonItems`.
       - addingCancelButton : Whether to add a `UIBarButtonItem` with `UIBarButtonSystemItem.cancel` to the `leftBarButtonItems`.
       - completion : Called after the presentation has completed.
    */
    func presentWithNavigationController(viewControllerToPresent : UIViewController, animated : Bool = true, addingDoneButton : Bool = false, addingCancelButton : Bool = false, completion : OKBlock? = nil){
        if addingDoneButton {
            viewControllerToPresent.navigationItem.rightBarButtonItems = (viewControllerToPresent.navigationItem.rightBarButtonItems ?? []) + [UIBarButtonItem(barButtonSystemItem: .done, target: viewControllerToPresent, action: #selector(dismiss(animated:completion:)))] // TODO: Look if this adds it to the right direction
        }
        if addingCancelButton {
            viewControllerToPresent.navigationItem.leftBarButtonItems = (viewControllerToPresent.navigationItem.leftBarButtonItems ?? []) + [UIBarButtonItem(barButtonSystemItem: .cancel, target: viewControllerToPresent, action: #selector(dismiss(animated:completion:)))] // TODO: Look if this adds it to the right direction
        }
        
        let navigationController = UINavigationController(rootViewController: viewControllerToPresent)
        
        present(navigationController, animated: animated, completion: completion)
    }
    
    /// Dismisses the responder animatedly.
    @objc func dismiss(){
        dismiss(animated: true, completion: nil)
    }
    
    /// Dismisses the responder animatedly.
    @objc func dismissWithoutAmbiguity(){
        dismiss()
    }
    
    // Whether the responder is presented modally.
    var isModal: Bool {
        if presentingViewController != nil {
            return true
        }
        if navigationController?.presentingViewController?.presentedViewController == navigationController {
            return true
        }
        if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        
        return false
    }
}
#endif
