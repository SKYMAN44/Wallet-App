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

final class HomeRouter: HomeRouterLogic {
    
    weak var controller: HomeViewController?
    weak var dataSource: HomeDataStore?
    
    public func routeToAnalytics() {
        navigateToAnalytics(source: controller, destination: AnalyticsViewController())
    }
    
    
    private func navigateToAnalytics(source: HomeViewController?, destination: AnalyticsViewController) {
        source?.hidesBottomBarWhenPushed = true
        source?.navigationController?.pushViewController(destination, animated: true)
        source?.hidesBottomBarWhenPushed = false
    }
}
