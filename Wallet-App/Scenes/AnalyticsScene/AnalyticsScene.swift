//
//  AnalyticsScene.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 12.03.2022.
//

import UIKit

enum AnalyticsScene {
    static func build() -> UIViewController {
        let viewController = AnalyticsViewController()
        let interactor = AnalyticsInteractor()
        let presenter = AnalyticsPresenter()
        let router = AnalyticsRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
