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

public class OKInformationController : UITableViewController {
    private let informations:[OKInformation]
    
    public init(object : OKInforming){
        informations = object.getInformations()
        super.init(nibName: nil, bundle: nil)
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        self.navigationItem.title = object.title
    }
    
    // MARK: - Table view data source
    
    override public func numberOfSections(in tableView : UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override public func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return informations.count
    }
    
    override public func tableView(_ tableView : UITableView, cellForRowAt indexPath : IndexPath) -> UITableViewCell {
        let object = informations[(indexPath as NSIndexPath).row]
        return _OKInformationCell(information: object)
    }
    
    override public func tableView(_ tableView : UITableView, didSelectRowAt indexPath : IndexPath) {
        informations[(indexPath as NSIndexPath).row].handler?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override public func tableView(_ tableView : UITableView, shouldShowMenuForRowAt indexPath : IndexPath) -> Bool {
        return informations[(indexPath as NSIndexPath).row].canCopy
    }
    
    override public func tableView(_ tableView : UITableView, canPerformAction action : Selector, forRowAt indexPath : IndexPath, withSender sender : Any?) -> Bool {
        if (action == #selector(copy(_:))){
            return informations[(indexPath as NSIndexPath).row].canCopy
        }
        return false
    }
    
    override public func tableView(_ tableView : UITableView, performAction action : Selector, forRowAt indexPath : IndexPath, withSender sender : Any?) {
        if (action == #selector(copy(_:))){
            let pasteboard = UIPasteboard.general
            pasteboard.string = informations[(indexPath as NSIndexPath).row].text
        }
    }
    
    required public init?(coder aDecoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
#endif
