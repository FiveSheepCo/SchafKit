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
        
        func buildValueString(with value : Double, precision : Int = 2, withAbbreviation : Bool = true, locale: Locale) -> String {
            let stringValue = (value/milestone).toFormattedString(decimals: precision, locale: locale)
            return "\(stringValue) \(withAbbreviation ? abbreviation : name)"
        }
    }
    
    // MARK: - Byte Size
    
    private static func metricMilestones(for baseName: String, baseAbbreviation: String, hasSubZeroTypes: Bool) -> [Milestone] {
        func milestone(_ milestone: Double, prefix: String, abbreviationPrefix: String) -> Milestone {
            .init(milestone: milestone, name: "\(prefix)\(baseName)".capitalized, abbreviation: "\(abbreviationPrefix)\(baseAbbreviation)")
        }
        
        var milestones: [Milestone] = []
        
        if hasSubZeroTypes {
            milestones.append(contentsOf: [
                milestone(0.000001, prefix: "Micro", abbreviationPrefix: "μ"),
                milestone(0.001, prefix: "Milli", abbreviationPrefix: "m")
            ])
        }
        
        milestones.append(contentsOf: [
            milestone(1, prefix: "", abbreviationPrefix: ""),
            milestone(1000, prefix: "Kilo", abbreviationPrefix: "K"),
            milestone(1000000, prefix: "Mega", abbreviationPrefix: "M"),
            milestone(1000000000, prefix: "Giga", abbreviationPrefix: "G"),
            milestone(1000000000000, prefix: "Peta", abbreviationPrefix: "P")
        ])
        
        return milestones
    }
    
    /// The common milestones for byte sizes.
    static let byteSizeMilestones : [Milestone] = metricMilestones(for: "byte", baseAbbreviation: "B", hasSubZeroTypes: false)
    
    /// Converts a byte size into a human readable string.
    ///
    /// - example: 1200 -> "1.2 KB"
    public static func getByteSizeString(from byteSize : Int, useAbbreviation : Bool = true, locale: Locale = .autoupdatingCurrent) -> String {
        return getString(from: Double(byteSize), with: byteSizeMilestones, threshold: 1, useAbbreviation: useAbbreviation, locale: locale)
    }
    
    /// The common milestones for bit sizes.
    static let bitSizeMilestones : [Milestone] = metricMilestones(for: "bit", baseAbbreviation: "bit", hasSubZeroTypes: false)
    
    /// Converts a bit size into a human readable string.
    ///
    /// - example: 1200 -> "1.2 Kbit"
    public static func getBitSizeString(from bitSize : Int, useAbbreviation : Bool = true, locale: Locale = .autoupdatingCurrent) -> String {
        return getString(from: Double(bitSize), with: bitSizeMilestones, threshold: 1, useAbbreviation: useAbbreviation, locale: locale)
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
    public static func getTimeString(from seconds: Double, useAbbreviation: Bool = true, locale: Locale = .autoupdatingCurrent) -> String {
        return getString(from: Double(seconds), with: timeMilestones, threshold: 1, useAbbreviation: useAbbreviation, locale: locale)
    }
    
    /// Produces a string from the given value and milestones.
    static func getString(from value: Double,
                           with milestones: [Milestone],
                           threshold: Double,
                           useAbbreviation: Bool = true,
                           locale: Locale = .autoupdatingCurrent) -> String {
        var milestones = milestones.sorted(by: { (lhs, rhs) -> Bool in
            return lhs.milestone < rhs.milestone
        })
        
        var lastMilestone : Milestone = milestones.removeFirst() // TODO: Make lowest default
        for milestone in milestones where value / milestone.milestone > threshold {
            lastMilestone = milestone
        }
        
        return lastMilestone.buildValueString(with: value, withAbbreviation: useAbbreviation, locale: locale)
    }
}
