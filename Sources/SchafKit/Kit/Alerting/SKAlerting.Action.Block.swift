#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
import Foundation

extension SKAlerting.Action {
    /// A block corresponding to a certain `SKAlerting.Action`.
    public typealias Block = (_ action: SKAlerting.Action, _ fieldValues: [String]) -> Void
}
#endif
