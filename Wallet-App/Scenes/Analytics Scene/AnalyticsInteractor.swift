//
//  AnalyticsInteractor.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation


protocol AnalyticsBusinessLogic {
    func showInformation(request: AnalyticsInfo.ShowInfo.Request)
}

protocol AnalyticsDataStore: AnyObject {
    var history: [Expenses]? { get }
}

final class AnalyticsInteractor: AnalyticsBusinessLogic, AnalyticsDataStore {
    var presenter: AnalyticsPresentationLogic?
    var worker = AnalyticsWorker()
    var history: [Expenses]?
    
    func showInformation(request: AnalyticsInfo.ShowInfo.Request) {
        let history = worker.getHistory()
        self.history = history
        let response = AnalyticsInfo.ShowInfo.Response(history: history)
        presenter?.presentData(response: response)
    }
}
