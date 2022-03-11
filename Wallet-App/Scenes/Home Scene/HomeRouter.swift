//
//  HomeRouter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

final class HomeRouter: HomeRouterLogic, HomeViewDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    public func routeToAnalytics() {
        guard let analyticsViewController = AnalyticsScene.build() as? AnalyticsViewController else { return }
        analyticsViewController.interactor?.history = dataStore?.history
        navigateToAnalytics(source: viewController, destination: analyticsViewController)
    }
    
    // пихнуть все в один
    private func navigateToAnalytics(source: HomeViewController?, destination: AnalyticsViewController) {
        source?.hidesBottomBarWhenPushed = true
        source?.navigationController?.pushViewController(destination, animated: true)
        source?.hidesBottomBarWhenPushed = false
    }
}
