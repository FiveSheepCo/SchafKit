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

public extension OKAppearance {
    class TableViewCellBackgroundView : UIView {
        
        public init(){
            super.init(frame: .zero)
            
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(TableViewCellBackgroundView.updateStyle),
                                                   name : OKAppearance.styleChangeNotification,
                                                   object: nil)
            if #available(iOS 10.0, *) {
                // TODO: Remove timer! Very bad implementation!
                Timer.scheduledTimer(withTimeInterval: 0.1,
                                     repeats: false,
                                     block: { (timer) in
                                        self.updateStyle()
                })
            }
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
        
        @objc func updateStyle(){
            self.backgroundColor = OKAppearance.Style.shared.tableCellSelectionColor
        }
        
        required init?(coder aDecoder : NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
#endif
