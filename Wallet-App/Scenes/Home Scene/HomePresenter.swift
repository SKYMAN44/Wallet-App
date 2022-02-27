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
        let mapped = response.cards.map {
            HomeInfo.ShowInfo.ViewModel.DisplayedCard(type: $0.type, edningNumbers: "**" + $0.cardNumber.suffix(4), balance: "$ " + $0.balance)
        }
        let viewModel = HomeInfo.ShowInfo.ViewModel(displayedCards: mapped)
        viewController?.displayContent(viewModel: viewModel)
    }
}
