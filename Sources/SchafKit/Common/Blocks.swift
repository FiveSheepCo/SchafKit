import Foundation

/// A block.
public typealias SKBlock = () -> Void

/// A block with a bool indicating whether the task was successfully completed.
public typealias SKCompletionStatusBlock = (_ completed : Bool) -> Void

/// A block with a json value.
public typealias SKJsonRetrievalBlock = (_ json : SKJsonRepresentable?) -> Void

/// A login block.
public typealias SKLoginReturnBlock = (_ user : String, _ password : String) -> Void
