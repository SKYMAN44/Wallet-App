//
//  HomeScene.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 10.03.2022.
//

import UIKit

enum HomeScene {
    //TODO take filemanager + router
    static func build() -> UIViewController {
        let viewController = HomeViewController()
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
