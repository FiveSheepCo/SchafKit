import Foundation

/// A block.
public typealias OKBlock = () -> Void

/// A block with a bool indicating whether the task was successfully completed.
public typealias OKCompletionStatusBlock = (_ completed : Bool) -> Void

/// A block with a json value.
public typealias OKJsonRetrievalBlock = (_ json : SKJsonRepresentable?) -> Void

/// A login block.
public typealias OKLoginReturnBlock = (_ user : String, _ password : String) -> Void
