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

/// A dispatch helper.
public class OKDispatchHelper {
    private static let _mainQueue = DispatchQueue.main
    private static let _userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
    private static let _utilityQueue = DispatchQueue.global(qos: .utility)
    private static let _backgroundQueue = DispatchQueue.global(qos: .background)
    
    /**
     Dispatches a block.
    
     - Parameters:
       - sync : Whether to dispatch the queue synchronously.
       - queue : The queue onto which to dispatch the block.
       - block : The block to dispatch.
    */
    public class func dispatch(on queue: DispatchQueue, sync: Bool = false, block: @escaping OKBlock){
        if (sync){
            queue.sync(execute: block)
        }else {
            queue.async(execute: block)
        }
    }
    
    /**
     Dispatches a block onto the main queue.
    
     - Parameters:
       - sync : Whether to dispatch the block synchronously.
       - block : The block to dispatch.
    */
    public class func dispatchOnMainQueue(sync : Bool = true, block:@escaping OKBlock){
        if (Thread.isMainThread){
            block()
        }else {
            dispatch(on: _mainQueue, sync: sync, block: block)
        }
    }
    
    /**
     Dispatches a block onto the global `userInitiated` queue.
    
     - Parameters:
       - sync : Whether to dispatch the block synchronously.
       - block : The block to dispatch.
    */
    public class func dispatchUserInitiatedTask(sync : Bool = false, block:@escaping OKBlock){
        dispatch(on: _userInitiatedQueue, sync: sync, block: block)
    }
    
    /**
     Dispatches a block onto the global `utility` queue.
    
     - Parameters:
       - sync : Whether to dispatch the block synchronously.
       - block : The block to dispatch.
    */
    public class func dispatchUtilityTask(sync : Bool = false, block:@escaping OKBlock){
        dispatch(on: _utilityQueue, sync: sync, block: block)
    }
    
    /**
     Dispatches a block onto the global `background` queue.
    
     - Parameters:
       - sync : Whether to dispatch the block synchronously.
       - block : The block to dispatch.
    */
    public class func dispatchBackgroundTask(sync : Bool = false, block:@escaping OKBlock){
        dispatch(on: _backgroundQueue, sync: sync, block: block)
    }
}
