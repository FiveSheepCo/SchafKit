import Foundation

public extension Result {
    var value: Success? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
    
    var failureValue: Failure? {
        if case .failure(let value) = self {
            return value
        }
        return nil
    }
}
