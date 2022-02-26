//
//  HomePresenter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation
import UIKit


protocol HomePresentationLogic {
    func presentData(response: HomeInfo.ShowInfo.Response)
}

final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeSceneDisplayLogic?
    
    
    func presentData(response: HomeInfo.ShowInfo.Response) {
        
    }
}
