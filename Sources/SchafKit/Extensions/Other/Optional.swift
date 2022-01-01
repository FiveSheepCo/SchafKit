import Foundation

extension Optional: Identifiable where Wrapped: Identifiable {
    public var id: some Hashable {
        return self?.id
    }
}
