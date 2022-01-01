import Foundation

public extension Double {
    
    /**
     Returns a string representing the receiver.
    
     - Remark : String() does not support optional chaining.
    */
    var toString : String {
        return String(self)
    }
    
    /**
     Returns a string representing the receiver, respecting the current locale.
    
     - Parameters:
       - decimals : The maximum number of decimals to display. Standard rounding is applied. The default is `2`.
       - separatesThousands : Whether thousands should be separated by the standard thousand separator of the current locale (e.g. `.` in english).
    */
    func toFormattedString(decimals : Int = 2, separatesThousands : Bool = true, locale: Locale = .autoupdatingCurrent) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = decimals
        formatter.usesGroupingSeparator = separatesThousands
        formatter.groupingSize = 3
        formatter.locale = locale
        return formatter.string(from : NSNumber(value: self)) ?? "0"
    }
}
