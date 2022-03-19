//
//  HomeRouter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

final class HomeRouter: HomeViewDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}

extension HomeRouter: HomeRouterLogic {
    public func routeToAnalytics() {
        guard let analyticsViewController = AnalyticsScene.build() as? AnalyticsViewController else { return }
        analyticsViewController.interactor?.history = dataStore?.history
        
        viewController?.hidesBottomBarWhenPushed = true
        viewController?.navigationController?.pushViewController(analyticsViewController, animated: true)
        viewController?.hidesBottomBarWhenPushed = false
    }
}
