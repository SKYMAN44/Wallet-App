//
//  AnalyticsWorker.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation

final class AnalyticsWorker {
    private var storageService: PersistanceStorage
    
    init(service: PersistanceStorage) {
        self.storageService = service
    }
    
    public func getHistory() -> [Expenses] {
        var expenses: [Expenses]?
        expenses = storageService.loadData(path: "Expenses")
        if let expenses = expenses {
            return expenses
        }
        return []
    }
    
    public func filterHistory(history: [Expenses], filterDate: Date) -> [Expenses] {
        var newHistory = history.filter { $0.date.compare(filterDate) == .orderedDescending }
        newHistory.sort(by: { $0.date > $1.date })
        
        return newHistory
    }
}
