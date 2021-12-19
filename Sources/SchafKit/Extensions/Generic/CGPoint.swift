//
//  CGPoint.swift
//  Scanner
//
//  Created by Jann Schafranek on 26.11.21.
//

import Foundation
import CoreGraphics

extension CGPoint {
    
    func distance(from b: CGPoint) -> CGFloat {
        let xDist = self.x - b.x
        let yDist = self.y - b.y
        return CGFloat(sqrt(xDist * xDist + yDist * yDist))
    }
}
