//
//  AnalyticsInteractor.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation

final class AnalyticsInteractor: AnalyticsDataStore {
    var presenter: AnalyticsPresentationLogic?
    var worker = AnalyticsWorker(service: FileService())
    var history: [Expenses]?
    
}

extension AnalyticsInteractor: AnalyticsBusinessLogic {
    func showInformation(request: AnalyticsInfo.ShowInfo.Request) {
        
        var filterDate: Date
        switch request.dateFilter {
        case .week:
            filterDate = DateFilters.startOfWeek
        case .month:
            filterDate = DateFilters.startOfMonth
        case .year:
            filterDate = DateFilters.startOfYear
        }
        
        let filtered = worker.filterHistory(history: self.history ?? [], filterDate: filterDate)
        let response = AnalyticsInfo.ShowInfo.Response(history: filtered)
        
        presenter?.presentData(response: response)
    }
}


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
        let month = gregorian.date(from: gregorian.dateComponents([.month], from: Date()))
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

