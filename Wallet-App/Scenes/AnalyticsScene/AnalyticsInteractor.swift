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
