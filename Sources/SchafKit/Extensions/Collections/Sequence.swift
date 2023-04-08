import Foundation

public protocol OptionalType {
    associatedtype Wrapped
    var optional: Wrapped? { get }
}

extension Optional: OptionalType {
    public var optional: Wrapped? { return self }
}

public extension Sequence where Iterator.Element: OptionalType {
    func removingNils() -> [Iterator.Element.Wrapped] {
        return self.compactMap { $0.optional }
    }
}
