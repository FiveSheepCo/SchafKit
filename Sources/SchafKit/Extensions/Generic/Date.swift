import Foundation

public extension Date {
    
    /// The time interval between  the current date and time and the date value.
    ///
    /// - REMARK: This is the negation of `timeIntervalSinceNow`.
    var timeIntervalUntilNow: TimeInterval {
        -timeIntervalSinceNow
    }
    
    /// Creates a date value initialized relative to the current date and time by a given number of seconds.
    ///
    /// - NOTE: Example Usage
    ///   ```
    ///   let dateFiveSecondsAgo = Date(timeIntervalUntilNow: 5)
    ///   ```
    ///
    /// - REMARK: This is the negation of `init(timeIntervalSinceNow:)`.
    init(timeIntervalUntilNow: TimeInterval) {
        self.init(timeIntervalSinceNow: -timeIntervalUntilNow)
    }
    
    /// Returns the date with all time information stripped (excluding timezone).
    var onlyDate: Date {
        get {
            let calendar = Calendar.current
            var components = calendar.dateComponents(
                [.year, .month, .day, .calendar, .timeZone], from: self
            )
            components.timeZone = TimeZone.autoupdatingCurrent
            return calendar.date(from: components)!
        }
    }
}
