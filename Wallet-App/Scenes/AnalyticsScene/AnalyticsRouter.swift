//
//  AnalyticsRouter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation

final class AnalyticsRouter: AnalyticsRouterLogic, AnalyticsViewDataPassing {
    weak var viewController: AnalyticsViewController?
    var dataStore: AnalyticsDataStore?
    
    func routeToHome() {
        
    }
}
