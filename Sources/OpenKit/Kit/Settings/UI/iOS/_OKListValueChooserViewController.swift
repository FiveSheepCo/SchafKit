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

internal class _OKListValueChooserViewController : UITableViewController {
    let listValues : [OKSettings.Setting.ListValue]
    let newValueHandler : (Int) -> Void
    
    var currentSelection : Int?
    
    init(title : String, listValues : [OKSettings.Setting.ListValue], currentValue : Int?, newValueHandler : @escaping (Int) -> Void) {
        self.listValues = listValues
        self.newValueHandler = newValueHandler
        
        self.currentSelection = currentValue
        
        super.init(style: .plain)
        
        self.title = title
        if #available(iOS 11.0, *) {
            self.navigationItem.largeTitleDisplayMode = .never
        }
    }
    
    override func numberOfSections(in tableView : UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return listValues.count
    }
    
    override func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let cell = _OKListValueChooserViewControllerCell(style: .default, reuseIdentifier: nil)
        
        let listValue = listValues[indexPath.row]
        
        cell.textLabel?.text = listValue.title
        cell.accessoryType = (listValue.value == currentSelection) ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
        let value = listValues[indexPath.row].value
        newValueHandler(value)
        
        currentSelection = value
        tableView.reloadData()
    }
    
    required init?(coder aDecoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
#endif
