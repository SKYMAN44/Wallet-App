//
//  AnalyticsRouter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation

protocol AnalyticsRouterLogic {
    func routeToHome()
}

protocol AnalyticsViewDataPassing {
    var dataStore: AnalyticsDataStore? { get }
}

final class AnalyticsRouter: AnalyticsRouterLogic, AnalyticsViewDataPassing {
    weak var controller: AnalyticsViewController?
    var dataStore: AnalyticsDataStore?
    
    func routeToHome() {
        
    }
}
