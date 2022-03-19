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
        let history = self.history ?? [ ]
        
        let response = AnalyticsInfo.ShowInfo.Response(history: history)
        presenter?.presentData(response: response)
    }
}
