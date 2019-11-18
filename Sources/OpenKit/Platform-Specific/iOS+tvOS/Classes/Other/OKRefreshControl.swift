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

private let yCenter : CGFloat = 30
private let beginBarrier : CGFloat = 20
private let endBarrier : CGFloat = 145 - beginBarrier
private let displacement : CGFloat = 0.5 - (1 - OKLoadingIndicator.portion / 2)

/// A modern equivalent to `UIRefreshControl`.
public class OKRefreshControl : UIRefreshControl {
    private var _displayLink : CADisplayLink? {
        willSet { _displayLink?.invalidate() }
        didSet { _displayLink?.add(to : RunLoop.main, forMode : RunLoop.Mode.common) }
    }
    private var _displacement : CGFloat = 0
    private var _currentEndBarrier : CGFloat?
    
    /// Returns a new `OKRefreshControl`.
    public override init() {
        super.init()
        
        self.backgroundColor = .clear
        self.tintColor = .clear
        
        self.frame.size.height = 0
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
    }
    
    public override var frame : CGRect { didSet { self.setNeedsDisplay() } }
    public override var isHidden: Bool { didSet { self.setNeedsDisplay() } }
    
    public override func draw(_ rect : CGRect) {
        if isHidden {
            return
        }
        
        let height = self.subviews.first?.frame.size.height ?? self.bounds.height
        
        let startAngle : CGFloat
        let endAngle : CGFloat
        
        if isRefreshing {
            if _displayLink == nil {
                _displacement = OKLoadingIndicator._getCurrentPortion() + displacement / 2
                _displayLink = CADisplayLink(target: self, selector: #selector(setNeedsDisplay as () -> Void))
            }
            
            startAngle = getCurrentAnimatedStartAngle()
            endAngle = startAngle + .pi * OKLoadingIndicator.portion
        } else {
            let relativeHeight = max(0, height - beginBarrier)
            
            if relativeHeight == 0 {
                _displacement = 0
                _currentEndBarrier = nil
            }
            
            startAngle = .pi * -displacement + _displacement
            endAngle = startAngle + .pi * OKLoadingIndicator.portion * min(1, relativeHeight / (_currentEndBarrier ?? endBarrier))
        }
        
        OKLoadingIndicator._draw(center : CGPoint(x: self.center.x, y: yCenter), startAngle: startAngle, endAngle: endAngle, tintColor: self.tintColor)
    }
    
    public override func endRefreshing() {
        super.endRefreshing()
        
        _displacement -= displacement / 2
        _displacement = getCurrentAnimatedStartAngle()
        _currentEndBarrier = self.frame.size.height - beginBarrier
        _displayLink = nil
    }
    
    private func getCurrentAnimatedStartAngle() -> CGFloat {
        return (OKLoadingIndicator._getCurrentPortion() - _displacement) * .pi * 2
    }
    
    required public init?(coder aDecoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
