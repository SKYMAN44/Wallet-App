//
//  AnalyticsProtocol.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 12.03.2022.
//

import Foundation

// MARK: - Presenter
protocol AnalyticsPresentationLogic {
    func presentData(response: AnalyticsInfo.ShowInfo.Response)
}

// MARK: - Router
protocol AnalyticsRouterLogic {
    func routeToHome()
}

protocol AnalyticsViewDataPassing {
    var dataStore: AnalyticsDataStore? { get }
}

// MARK: - Controller
protocol AnalyticsDisplayLogic: AnyObject {
    func displayContent(viewModel: AnalyticsInfo.ShowInfo.ViewModel)
}

// MARK: - Interactor
protocol AnalyticsBusinessLogic {
    func showInformation(request: AnalyticsInfo.ShowInfo.Request)
}

protocol AnalyticsDataStore {
    var history: [Expenses]? { get set }
}
