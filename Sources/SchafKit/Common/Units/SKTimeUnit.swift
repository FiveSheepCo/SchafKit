import Foundation

/// A common time unit.
public enum SKTimeUnit : Double {
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
    public func convert(to : SKTimeUnit) -> Double {
        return self.rawValue / to.rawValue
    }
    
    /**
     Converts one time unit to another.
    
     - Note : This returns an integer, making it only viable to use to convert lower into higher units.
    */
    public func convertInteger(to : SKTimeUnit) -> Int {
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
        return rawValue / SKTimeUnit.second.rawValue
    }
}
