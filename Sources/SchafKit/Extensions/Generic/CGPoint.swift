import Foundation
#if os(OSX) || os(iOS) || os(tvOS) || os(watchOS)
import CoreGraphics

public extension CGPoint {
    
    func distance(from b: CGPoint) -> CGFloat {
        let xDist = self.x - b.x
        let yDist = self.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
}
#endif
