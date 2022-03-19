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
        let newHistory = history.filter({ $0.date >= filterDate })
        
        return newHistory
    }
}
