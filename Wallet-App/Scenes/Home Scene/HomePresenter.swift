//
//  HomePresenter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation
import UIKit

final class HomePresenter: HomePresentationLogic {
    weak var viewController: HomeSceneDisplayLogic?
    
    func presentData(response: HomeInfo.ShowInfo.Response) {
        // вынести в 3 метода
        let mapped = response.cards.map {
            HomeInfo.ShowInfo.ViewModel.DisplayedCard(
                type: $0.type,
                edningNumbers: "**" + $0.cardNumber.suffix(4),
                balance: "$ " + "\($0.balance)"
            )
        }
        let mappedC = response.contacts.map {
            HomeInfo.ShowInfo.ViewModel.DisplayedContact(id: $0.id, imageURL: $0.imageURL)
        }
        let mappedH = response.history.map {
            HomeInfo.ShowInfo.ViewModel.DisplayedHistory(
                recieverName: $0.recieverName,
                date: $0.date.format(), image: "purpleGradient.jpg",
                amount: "- $" + "\($0.amount)"
            )
        }
        let viewModel = HomeInfo.ShowInfo.ViewModel(displayedCards: mapped, displayedContact: mappedC, displayedHistory: mappedH)
        viewController?.displayContent(viewModel: viewModel)
    }
}
