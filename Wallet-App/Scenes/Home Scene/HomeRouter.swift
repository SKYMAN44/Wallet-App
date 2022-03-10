//
//  HomeRouter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

protocol HomeRouterLogic {
    func routeToAnalytics()
}

protocol HomeViewDataPassing {
    var dataStore: HomeDataStore? { get }
}

final class HomeRouter: HomeRouterLogic, HomeViewDataPassing {
    weak var controller: HomeViewController?
    var dataStore: HomeDataStore?
    
    public func routeToAnalytics() {
        let analyticsViewController = AnalyticsViewController()
        var destinationDS = analyticsViewController.router?.dataStore
        passDataToAnalytics(source: dataStore, destination: &destinationDS)
        navigateToAnalytics(source: controller, destination: analyticsViewController)
    }
    
    private func navigateToAnalytics(source: HomeViewController?, destination: AnalyticsViewController) {
        source?.hidesBottomBarWhenPushed = true
        source?.navigationController?.pushViewController(destination, animated: true)
        source?.hidesBottomBarWhenPushed = false
    }
    
    private func passDataToAnalytics(source: HomeDataStore?, destination: inout AnalyticsDataStore?) {
        guard let source = source else { return }
        destination?.history = source.history
    }
}
