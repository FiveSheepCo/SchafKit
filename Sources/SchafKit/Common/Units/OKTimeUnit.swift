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

/// A common time unit.
public enum OKTimeUnit : Double {
    /// A millisecond.
    case millisecond = 0.001
    /// A second.
    case second = 1
    /// A minute.
    case minute = 60
    /// An hour.
    case hour = 3600
    /// A day.
    case day = 86400
    /// A week.
    case week = 604800
    /// A year.
    case year = 31536000
    /// A decade.
    case decade = 315360000
    /// A century.
    case century = 3153600000
    
    /// Converts one time unit to another.
    public func convert(to : OKTimeUnit) -> Double {
        return self.rawValue / to.rawValue
    }
    
    /**
     Converts one time unit to another.
    
     - Note : This returns an integer, making it only viable to use to convert lower into higher units.
    */
    public func convertInteger(to : OKTimeUnit) -> Int {
        return Int(convert(to: to))
    }
    
    /// The name of the receiver. Localizable.
    var name : String {
        switch self {
        case .second:
            return "Seconds".localized
        case .minute:
            return "Minutes".localized
        case .hour:
            return "Hours".localized
        case .day:
            return "Days".localized
        case .week:
            return "Weeks".localized
        case .year:
            return "Years".localized
        default:
            return .empty
        }
    }
    
    /// The time interval of the receiver.
    var timeInterval : TimeInterval {
        return rawValue / OKTimeUnit.second.rawValue
    }
}
