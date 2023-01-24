//
//  Date+Extension.swift
//  brew-swiftUI
//
//  Created by Jennifer Munro-Brown on 16/11/2022.
//

import Foundation

extension Date {

    static private let formatter = DateFormatter()

    private enum Constants {
        static let secondsInDay: Double = 86400
        static let secondsInHour: Double = 3600
        static let secondsInMinute: Double = 60
        static let hoursInDay: Double = 24
        static let daysInWeek: Double = 7

        static let justUpdatedText: String = "just now..."
        static let minutesText: String = "minutes ago..."
        static let hoursText: String = "hours ago..."
        static let daysText: String = "days ago..."
    }

    ///  Returns a short string to indicate how much time has passed
    ///  between the current date time and the passed in date time
    ///
    /// - Parameter startDate: the starting date time
    /// - Returns: a string representation of the time elapsed
    static func timeElapsedString(since startDate: Date) -> String {
        let now = Date()
        let secondsBeforeNow = now.secondsSince(date: startDate)
        let minutesBeforeNow = now.minutesSince(date: startDate)
        let hoursBeforeNow = now.hoursSince(date: startDate)
        let daysBeforeNow = now.daysSince(date: startDate)

        if secondsBeforeNow < Constants.secondsInMinute {
            return Constants.justUpdatedText
        } else if minutesBeforeNow < Constants.secondsInMinute {
            return "\(Int(minutesBeforeNow)) \(Constants.minutesText)"
        } else if hoursBeforeNow < Constants.hoursInDay {
            return "\(Int(hoursBeforeNow)) \(Constants.hoursText)"
        } else if daysBeforeNow <= Constants.daysInWeek {
            return "\(Int(daysBeforeNow)) \(Constants.daysText)"
        } else {
            formatter.setLocalizedDateFormatFromTemplate("M/d/yyyy")
            return formatter.string(from: startDate)
        }
    }

    private func secondsSince(date startDate: Date) -> Double {
        timeIntervalSince(startDate).rounded()
    }

    private func minutesSince(date startDate: Date) -> Double {
        (timeIntervalSince(startDate) / Constants.secondsInMinute).rounded()
    }

    private func hoursSince(date startDate: Date) -> Double {
        (timeIntervalSince(startDate) / Constants.secondsInHour).rounded()
    }

    private func daysSince(date startDate: Date) -> Double {
        (timeIntervalSince(startDate) / Constants.secondsInDay).rounded()
    }
}
