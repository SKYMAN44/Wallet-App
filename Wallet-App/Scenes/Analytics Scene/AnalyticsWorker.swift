//
//  AnalyticsWorker.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation

final class AnalyticsWorker {
    func getHistory() -> [Expenses] {
        return DBService.shared.getExpenses()
    }
}
