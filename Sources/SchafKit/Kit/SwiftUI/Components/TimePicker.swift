//
//  TimePicker.swift
//  LockdownWatch WatchKit Extension
//
//  Created by Marco Quinten on 23.04.21.
//

#if os(watchOS) && canImport(SwiftUI)

import SwiftUI

public class TimeComponent: ObservableObject {
    @Published public var hour: Double
    @Published public var minute: Double
    
    public init(h: Double, m: Double) {
        hour = h
        minute = m
    }
    
    public init(_ t: TimeInterval) {
        hour = trunc(t)
        minute = (t - trunc(t)) * 60
    }
    
    public func update(_ t: TimeInterval) {
        hour = trunc(t)
        minute = (t - trunc(t)) * 60
    }
    
    public var wholeHour: Int {
        Int(hour.rounded(.toNearestOrAwayFromZero))
    }
    
    public var wholeMinute: Int {
        Int(minute.rounded(.toNearestOrAwayFromZero))
    }
    
    public var time: TimeInterval {
        hour + minute / 60
    }
}

@available(watchOS 7, *)
public struct TimePicker: View {
    @ObservedObject public var timeComponent: TimeComponent
    
    @State private var hourFocused: Bool = false
    @State private var minuteFocused: Bool = false
    @State private var curfewEnabled: Bool = true

    static let formatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()

    public var body: some View {
        HStack {
            Text("\(timeComponent.wholeHour, specifier: "%02d")")
                .font(.title3)
                .focusable(true, onFocusChange: { focused in
                    hourFocused = focused
                })
                .digitalCrownRotation(
                    $timeComponent.hour,
                    from: 0,
                    through: 24,
                    by: 1,
                    sensitivity: .medium,
                    isContinuous: false,
                    isHapticFeedbackEnabled: true
                )
                .padding(.horizontal, 4)
                .border(Color.accentColor, width: hourFocused ? 2 : 0)
                .cornerRadius(3)
            Text(":")
            Text("\(timeComponent.wholeMinute, specifier: "%02d")")
                .font(.title3)
                .focusable(true, onFocusChange: { focused in
                    minuteFocused = focused
                })
                .digitalCrownRotation(
                    $timeComponent.minute,
                    from: 0,
                    through: 59,
                    by: 1,
                    sensitivity: .medium,
                    isContinuous: false,
                    isHapticFeedbackEnabled: true
                )
                .padding(.horizontal, 4)
                .border(Color.accentColor, width: minuteFocused ? 2 : 0)
                .cornerRadius(3)
        }
    }
}

#endif
