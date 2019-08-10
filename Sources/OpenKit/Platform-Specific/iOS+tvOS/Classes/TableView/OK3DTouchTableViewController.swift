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

/// Offers an easy way to make a UITableViewController support 3D Touch Peek and Pop.
public class OK3DTouchTableViewController : UITableViewController, UIViewControllerPreviewingDelegate {
    private var previewingContext : UIViewControllerPreviewing?
    
    /// Defines the way in which `UIViewController`s are shown.
    var showingStyle : ShowingStyle = .push
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 9.0, *) {
            self.previewingContext = self.registerForPreviewing(with: self, sourceView: self.tableView)
        }
    }
    
    @available(iOS 9.0, *)
    public func previewingContext(_ previewingContext : UIViewControllerPreviewing, viewControllerForLocation location : CGPoint) -> UIViewController? {
        if let indexPath = self.tableView.indexPathForRow(at: location){
            previewingContext.sourceRect = self.tableView.rectForRow(at: indexPath)
            return self.tableView(self.tableView, peekViewControllerForRowAt: indexPath)
        }
        return nil
    }
    
    public func previewingContext(_ previewingContext : UIViewControllerPreviewing, commit viewControllerToCommit : UIViewController) {
        if let navigationController = self.navigationController, showingStyle == .push {
            navigationController.show(viewControllerToCommit, sender: nil)
        }else {
            self.present(viewControllerToCommit, animated: false, completion: nil)
        }
    }
    
    /// Returns the `UIViewController` to peek (and, possibly, pop) for the given `IndexPath`.
    public func tableView(_ tableView : UITableView, peekViewControllerForRowAt indexPath : IndexPath) -> UIViewController? {
        return nil
    }
    
    override public func numberOfSections(in tableView : UITableView) -> Int {
        fatalError("numberOfSections not implemented in JS3DTouchTableViewController subclass")
    }
    
    override public func tableView(_ tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        fatalError("numberOfRows not implemented in JS3DTouchTableViewController subclass")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
#endif
