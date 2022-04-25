//
//  Date+Extension.swift
//  BreakingBad
//
//  Created by Niklas Alvaeus on 15/03/2021.
//

import Foundation

extension Date {
    init(dateString:String) {
        self = Date.iso8601Formatter.date(from: dateString) ?? Date()
    }
    
    static let iso8601Formatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withSpaceBetweenDateAndTime,
                                   .withFullDate,
                                   .withTime,
                                   .withDashSeparatorInDate,
                                   .withColonSeparatorInTime]
        return formatter
    }()
}

extension Date {
    func ordinalDateFormatted() -> String {
        let calendar = Calendar.current
        let dateComponents = calendar.component(.day, from: self)
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .ordinal
        
        let day = numberFormatter.string(from: dateComponents as NSNumber)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM"
        let dateString = "\(day!) \(dateFormatter.string(from: self))"
        return dateString
    }
}

extension DateFormatter {
    static let ddMMM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

    
    static let MMddyyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
    static let yyyyMMddHis: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss" // 2021-11-16 16:11:50
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX") // need this as date decoding breaks on some phones...
        return formatter
    }()
}
