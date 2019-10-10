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

private let animationDuration : TimeInterval = 0.25
private let contentSizeKey = "preferredContentSize"

public class OKSegmentedViewController : UINavigationController {
    public var switchableViewControllers : [UIViewController] = [] { didSet{ reloadSegmentedControl() } }
    private let segmentedControl = UISegmentedControl(items: [])
    
    private var activeViewController : UIViewController! {
        willSet {
            activeViewController?.removeObserver(self, forKeyPath: contentSizeKey)
        }
        didSet {
            activeViewController.navigationItem.titleView = segmentedControl
            self.setViewControllers([activeViewController], animated: false)
            updatePreferredContentSize()
            
            activeViewController.addObserver(self, forKeyPath: contentSizeKey)
        }
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public init (viewControllers : [UIViewController]) {
        activeViewController = viewControllers.first!
        
        super.init(rootViewController: activeViewController)
        
        switchableViewControllers = viewControllers
        reloadSegmentedControl()
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        self.navigationItem.titleView = segmentedControl
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(updateActiveController), for: .valueChanged)
    }
    
    public func selectViewController(at index : Int) {
        segmentedControl.selectedSegmentIndex = index
        segmentedControl.becomeFirstResponder()
    }
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        updatePreferredContentSize()
    }
    
    private func reloadSegmentedControl() {
        segmentedControl.removeAllSegments()
        
        for controller in switchableViewControllers.reversed() {
            segmentedControl.insertSegment(withTitle: controller.title, at: 0, animated: false)
        }
        
        if segmentedControl.selectedSegmentIndex == -1 {
            segmentedControl.selectedSegmentIndex = 0
        }
        
        updateActiveController()
    }
    
    @objc public func updateActiveController() {
        guard let controller = switchableViewControllers[ifExists: segmentedControl.selectedSegmentIndex] else {
            return
        }
        activeViewController = controller
    }
    
    private func updatePreferredContentSize() {
        UIView.animate(withDuration: animationDuration) {
            self.willChangeValue(forKey: contentSizeKey)
            self.didChangeValue(forKey: contentSizeKey)
        }
    }
    
    public override var preferredContentSize: CGSize {
        get {
            var size = activeViewController.preferredContentSize
            size.height += self.navigationBar.frame.size.height
            return size
        }
        set {
            print("Setting the preferredContentSize on a JSSegmentedViewController is not supported and will be ignored.")
        }
    }
}
#endif
