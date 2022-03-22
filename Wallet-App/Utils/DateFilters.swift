//
//  DataFilters.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 22.03.2022.
//

import Foundation

class DateFilters {
    static var startOfToday: Date {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        return calendar.startOfDay(for: Date())
    }
    
    static var startOfWeek: Date {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.timeZone = TimeZone(secondsFromGMT: 0)!
        let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))
        
        return gregorian.date(byAdding: .day, value: 1, to: sunday!)!
    }
    
    static var startOfMonth: Date {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.timeZone = TimeZone(secondsFromGMT: 0)!
        let month = gregorian.date(from: gregorian.dateComponents([.month, .year], from: Date()))
        let monthStart = gregorian.startOfDay(for: month!)
        
        return monthStart
    }
    
    static var startOfYear: Date {
        var gregorian = Calendar(identifier: .gregorian)
        gregorian.timeZone = TimeZone(secondsFromGMT: 0)!
        let year = gregorian.date(from: gregorian.dateComponents([.year], from: Date()))
        let yearStart = gregorian.startOfDay(for: year!)
        
        return yearStart
    }
}
