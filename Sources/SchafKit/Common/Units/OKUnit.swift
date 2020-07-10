//  Copyright (c) 2020 Quintschaf GbR
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

// TODO: Put in enum
// TODO: Standard Metric Stuff

/// A class helping with the display of measurements in units, currently bytes and time.
public class OKUnit {
    /// A common milestone.
    struct Milestone {
        let milestone : Double
        let name : String
        let abbreviation : String
        
        func buildValueString(with value : Double, precision : Int = 2, withAbbreviation : Bool = true) -> String {
            let stringValue = String(format: "%.\(precision)f", value/milestone)
            return "\(stringValue) \(withAbbreviation ? abbreviation : name)"
        }
    }
    
    // MARK: - Byte Size
    
    /// The common milestones for byte sizes.
    static let byteSizeMilestones : [Milestone] = [
        Milestone(milestone: 1, name: "Byte", abbreviation: "B"),
        Milestone(milestone: 1000, name: "Kilobyte", abbreviation: "KB"),
        Milestone(milestone: 1000000, name: "Megabyte", abbreviation: "MB"),
        Milestone(milestone: 1000000000, name: "Gigabyte", abbreviation: "GB"),
        Milestone(milestone: 1000000000000, name: "Petabyte", abbreviation: "PB")
    ]
    
    /// Converts a byte size into a human readable string.
    ///
    /// - example: 1200 -> "1.2 KB"
    public static func getByteSizeString(from byteSize : Int, useAbbreviation : Bool = true) -> String {
        return getString(from: Double(byteSize), with: byteSizeMilestones, threshold: 1, useAbbreviation: useAbbreviation)
    }
    
    /// The common milestones for bit sizes.
    static let bitSizeMilestones : [Milestone] = [
        Milestone(milestone: 1, name: "Bit", abbreviation: "bit"),
        Milestone(milestone: 1000, name: "Kilobit", abbreviation: "Kbit"),
        Milestone(milestone: 1000000, name: "Megabit", abbreviation: "Mbit"),
        Milestone(milestone: 1000000000, name: "Gigabit", abbreviation: "Gbit"),
        Milestone(milestone: 1000000000000, name: "Petabit", abbreviation: "Pbit")
    ]
    
    /// Converts a bit size into a human readable string.
    ///
    /// - example: 1200 -> "1.2 Kbit"
    public static func getBitSizeString(from bitSize : Int, useAbbreviation : Bool = true) -> String {
        return getString(from: Double(bitSize), with: bitSizeMilestones, threshold: 1, useAbbreviation: useAbbreviation)
    }
    
    // MARK: - Time
    
    /// The common milestones for time.
    static let timeMilestones : [Milestone] = [
        Milestone(milestone: 0.001, name: "Millisecond", abbreviation: "ms"),
        Milestone(milestone: 1, name: "Second", abbreviation: "s"),
        Milestone(milestone: 60, name: "Minute", abbreviation: "min"),
        Milestone(milestone: 3600, name: "Hour", abbreviation: "h"),
        Milestone(milestone: 86400, name: "Day", abbreviation: "d")
    ]
    
    /// Converts seconds into a human readable string.
    ///
    /// - example: 1200 -> "20 min"
    public static func getTimeString(from seconds: Double, useAbbreviation: Bool = true) -> String {
        return getString(from: Double(seconds), with: timeMilestones, threshold: 1, useAbbreviation: useAbbreviation)
    }
    
    /// Produces a string from the given value and milestones.
    static func getString(from value: Double,
                           with milestones: [Milestone],
                           threshold: Double,
                           useAbbreviation: Bool = true) -> String {
        var milestones = milestones.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.milestone < rhs.milestone
        })
        
        var lastMilestone : Milestone = milestones.removeFirst() // TODO: Make lowest default
        for milestone in milestones where value / milestone.milestone > threshold {
            lastMilestone = milestone
        }
        
        return lastMilestone.buildValueString(with: value, withAbbreviation: useAbbreviation)
    }
}
