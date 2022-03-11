//
//  AnalyticsInteractor.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation

final class AnalyticsInteractor: AnalyticsBusinessLogic, AnalyticsDataStore {
    var presenter: AnalyticsPresentationLogic?
    var worker = AnalyticsWorker(service: FileService())
    var history: [Expenses]?
    
    func showInformation(request: AnalyticsInfo.ShowInfo.Request) {
//        let history = worker.getHistory()
//        self.history = history
        let history = self.history ?? [ ]
        let response = AnalyticsInfo.ShowInfo.Response(history: history)
        presenter?.presentData(response: response)
    }
}
