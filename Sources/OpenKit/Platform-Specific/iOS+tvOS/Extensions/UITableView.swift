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

public extension UITableView {
    /// Updates the receiver.
    ///
    /// - parameter animated: Whether the update is animated.
    ///
    /// - Note: This can be used to recalculate row heights when using UITableViewAutomaticDimension.
    func update(animated : Bool = true) {
        let animationsWereEnabled = UIView.areAnimationsEnabled
        UIView.setAnimationsEnabled(animated)
        beginUpdates()
        endUpdates()
        UIView.setAnimationsEnabled(animationsWereEnabled)
    }
    
    /// Automatically updates (moves, inserts and deletes) a section in the receiver from one array (of equatables) to another.
    func update <T:Equatable>(section : Int, from : [T], to : [T], animation : UITableView.RowAnimation = .automatic) {
        if from == to {
            return
        }
        
        beginUpdates()
        
        var from = from
        
        // Delete removed rows
        for oldIndex in (0..<from.count).reversed() {
            let oldItem = from[oldIndex]
            
            if !to.contains(oldItem) {
                from.remove(at: oldIndex)
                deleteRows(at: [IndexPath(row: oldIndex, section: section)], with: animation)
            }
        }
        
        // Move changed and insert new rows
        for newIndex in 0..<to.count {
            while to[newIndex] != from[ifExists: newIndex] {
                let newItem = to[newIndex]
                
                if let oldIndex = from.firstIndex(of: newItem) {
                    from.insert(from.remove(at: oldIndex), at: newIndex)
                    moveRow(at: IndexPath(row: oldIndex, section: section), to: IndexPath(row: newIndex, section: section))
                } else {
                    from.insert(newItem, at: newIndex)
                    insertRows(at: [IndexPath(row: newIndex, section: section)], with: animation)
                }
            }
        }
        
        endUpdates()
    }
}
#endif
