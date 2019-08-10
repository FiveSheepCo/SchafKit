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

class _OKInformationCell : UITableViewCell {
    let information : OKInformation
    
    init(information : OKInformation){
        self.information = information
        
        super.init(style: .value2, reuseIdentifier: nil)
        
        self.load()
    }
    
    deinit {
        // TODO: Remove style observer
    }
    
    func load(){
        let text : String
        if !information.isLoading {
            if let actualText = information.text {
                text = actualText
            }else {
                text = "No value".localized()
            }
            
            self.selectionStyle = .default
            if (information.handler != nil){
                self.accessoryType = .disclosureIndicator
            }else {
                self.accessoryType = .none
                if !(information.canCopy){
                    self.selectionStyle = .none
                }
            }
        }else {
            text = "Loading...".localized()
            self.accessoryView = OKLoadingIndicator(middle : CGPoint.zero)
        }
        self.detailTextLabel?.text = text
        //actualDetailTextLabel.sizeToFit()
        
        self.textLabel?.text = information.type
    }
    
    override func observeValue(forKeyPath keyPath : String?, of object : Any?, change: [NSKeyValueChangeKey : Any]?, context : UnsafeMutableRawPointer?) {
        OKDispatchHelper.dispatchOnMainQueue {
            self.load()
        }
    }
    
    required init?(coder aDecoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected : Bool, animated : Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
#endif
