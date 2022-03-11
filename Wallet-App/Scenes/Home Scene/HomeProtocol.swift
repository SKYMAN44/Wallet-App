//
//  HomeProtocol.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 10.03.2022.
//

import Foundation

// MARK: - Presenter
protocol HomePresentationLogic {
    func presentData(response: HomeInfo.ShowInfo.Response)
}

// MARK: - Router
protocol HomeRouterLogic {
    func routeToAnalytics()
}

protocol HomeViewDataPassing {
    var dataStore: HomeDataStore? { get }
}

// MARK: - Controller
protocol HomeSceneDisplayLogic: AnyObject {
    func displayContent(viewModel: HomeInfo.ShowInfo.ViewModel)
}

// MARK: - Interactor
protocol HomeBusinessLogic {
    func showInformation(request: HomeInfo.ShowInfo.Request)
}

protocol HomeDataStore: AnyObject {
    // в респонс переделать
    var cards: [Card]? { get }
    var contacts: [Contact]? { get }
    var history: [Expenses]? { get }
}
