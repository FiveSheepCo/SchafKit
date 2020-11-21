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

#if os(iOS) || os(tvOS)
import UIKit

public extension UIView {
    internal static let standardSystemSpacing : CGFloat = 8
    internal static let standardProminentSystemSpacing : CGFloat = 12
    internal static let standardSystemTableViewCellSpacing : CGFloat = 20
    
    /// The system spacing.
    var systemSpacing : CGFloat { return UIView.standardSystemSpacing }
    
    /// The prominent system spacing.
    var prominentSystemSpacing : CGFloat { return UIView.standardProminentSystemSpacing }
    
    /// The double system spacing.
    ///
    /// - Note: This is commonly used as the spacing between the border of the dislpay and the first element or other elements that have to be clearly separated.
    var doubleSystemSpacing : CGFloat { return 2 * UIView.standardSystemSpacing }
    
    /// The system table view cell spacing.
    var systemTableViewCellSpacing : CGFloat { return UIView.standardSystemTableViewCellSpacing }
    
    /// Detects whether the responder contains the given touch.
    func contains(_ touch : UITouch) -> Bool {
        return bounds.contains(touch.location(in: self))
    }
    
    /// Removes all subviews from the responder.
    func removeAllSubviews(){
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    /// Returns the first responder inside the responders underlying view hierarchy, if exists.
    var firstResponder : UIResponder?{
        if isFirstResponder {
            return self
        }
        for view in subviews {
            if let firstResponder = view.firstResponder {
                return firstResponder
            }
        }
        return nil
    }
    
    /**
     Returns a snapshot of the responder.
    
     - Note : The snapshot has the dimensions (size and scale) of the current view.
    */
    var snapshot : UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        self.layer.render(in: context);
        
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return screenshot
    }
    
    /// Returns all constraints held by the receiver with their identifier set to the given id.
    func constraints(identifiedBy id : String?) -> [NSLayoutConstraint] {
        return constraints.filter({ (constraint) -> Bool in
            return constraint.identifier == id
        })
    }
}
#endif
