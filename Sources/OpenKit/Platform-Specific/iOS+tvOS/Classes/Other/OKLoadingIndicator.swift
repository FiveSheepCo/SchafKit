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

private let lineWidth = 1
private let radius : CGFloat = 12

/// A modern equivalent to `UILoadingIndicator`.
public class OKLoadingIndicator : UIView {
    public struct Constants {
        public static let diameter : CGFloat = 26
    }
    
    internal static let portion : CGFloat = 1.8
    
    private var _displayLink : CADisplayLink? {
        willSet { _displayLink?.invalidate() }
        didSet { _displayLink?.add(to : RunLoop.main, forMode : RunLoop.Mode.common) }
    }
    
    public override var isHidden : Bool {
        didSet {
            self.didChangeValue(forKey: "isHidden")
            self._reloadDisplayLink()
        }
    }
    
    /// Returns a new `OKLoadingIndicator`.
    public init(){
        super.init(frame : CGRect(origin : CGPoint.zero,
                                  size : CGSize(width: Constants.diameter, height: Constants.diameter)))
        initialize()
    }
    
    /// Returns a new `OKLoadingIndicator` centered at the `middle`.
    public init (middle : CGPoint){
        super.init(frame : CGRect(x: middle.x - Constants.diameter / 2,
                                  y: middle.y - Constants.diameter / 2,
                                  width: Constants.diameter,
                                  height: Constants.diameter))
        initialize()
    }
    
    /// Returns a new `OKLoadingIndicator` origin of which is set to `origin`.
    public init (origin : CGPoint){
        super.init(frame : CGRect(origin: origin,
                                  size : CGSize(width: Constants.diameter, height: Constants.diameter)))
        initialize()
    }
    
    required public init?(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)
        self.frame.size.width = Constants.diameter
        self.frame.size.height = Constants.diameter
        initialize()
    }
    
    private func initialize(){
        _reloadDisplayLink()
        self.backgroundColor = .clear
        
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: Constants.diameter)
        heightConstraint.priority = .defaultHigh
        heightConstraint.activate()
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: Constants.diameter)
        widthConstraint.priority = .defaultHigh
        widthConstraint.activate()
    }
    
    private func _reloadDisplayLink() {
        if isHidden {
            _displayLink = nil
        } else {
            _displayLink = CADisplayLink(target: self, selector: #selector(setNeedsDisplay as () -> Void))
        }
    }
    
    override public func draw(_ rect : CGRect) {
        let startAngle = OKLoadingIndicator._getCurrentPortion() * .pi * 2
        OKLoadingIndicator._draw(center: actualCenter, startAngle: startAngle, endAngle: startAngle + .pi * OKLoadingIndicator.portion, tintColor: self.tintColor)
    }
    
    internal static func _draw(center : CGPoint, startAngle : CGFloat, endAngle : CGFloat, tintColor : UIColor) {
        let context : CGContext = UIGraphicsGetCurrentContext()!
        context.beginPath()
        context.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        context.setStrokeColor(tintColor.cgColor)
        context.setLineWidth(1)
        context.strokePath()
    }
    
    internal static func _getCurrentPortion() -> CGFloat {
        let time = CACurrentMediaTime()
        return CGFloat(time - floor(time))
    }
    
    internal var actualCenter : CGPoint {
        let bounds = self.bounds
        return CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
    }
}
#endif
