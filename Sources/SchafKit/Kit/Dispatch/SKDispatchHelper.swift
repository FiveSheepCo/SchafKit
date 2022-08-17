#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

/// A dispatch helper.
public class SKDispatchHelper {
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
    public class func dispatch(on queue: DispatchQueue, sync: Bool = false, block: @escaping SKBlock){
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
    public class func dispatchOnMainQueue(sync : Bool = true, block:@escaping SKBlock){
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
    public class func dispatchUserInitiatedTask(sync : Bool = false, block:@escaping SKBlock){
        dispatch(on: _userInitiatedQueue, sync: sync, block: block)
    }
    
    /**
     Dispatches a block onto the global `utility` queue.
    
     - Parameters:
       - sync : Whether to dispatch the block synchronously.
       - block : The block to dispatch.
    */
    public class func dispatchUtilityTask(sync : Bool = false, block:@escaping SKBlock){
        dispatch(on: _utilityQueue, sync: sync, block: block)
    }
    
    /**
     Dispatches a block onto the global `background` queue.
    
     - Parameters:
       - sync : Whether to dispatch the block synchronously.
       - block : The block to dispatch.
    */
    public class func dispatchBackgroundTask(sync : Bool = false, block:@escaping SKBlock){
        dispatch(on: _backgroundQueue, sync: sync, block: block)
    }
}
#endif
