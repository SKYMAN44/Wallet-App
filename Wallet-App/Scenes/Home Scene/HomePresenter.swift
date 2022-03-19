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
    
    private func mapCards(_ items: [Cards]) -> [HomeInfo.ShowInfo.ViewModel.DisplayedCard] {
        let mapped = items.map {
            HomeInfo.ShowInfo.ViewModel.DisplayedCard(
                type: $0.type,
                edningNumbers: "**" + $0.cardNumber.suffix(4),
                balance: "$ " + "\($0.balance)"
            )
        }
        
        return mapped
    }
    
    private func mapContacts(_ items: [Contacts]) -> [HomeInfo.ShowInfo.ViewModel.DisplayedContact] {
        let mapped = items.map {
            HomeInfo.ShowInfo.ViewModel.DisplayedContact(id: $0.id, imageURL: $0.imageURL)
        }
        
        return mapped
    }
    
    private func mapHistory(_ items: [Expenses]) -> [HomeInfo.ShowInfo.ViewModel.DisplayedHistory] {
        let mapped = items.map {
            HomeInfo.ShowInfo.ViewModel.DisplayedHistory(
                recieverName: $0.recieverName,
                date: $0.date.format(), image: "purpleGradient.jpg",
                amount: "- $" + "\($0.amount)"
            )
        }
        
        return mapped
    }
    
    public func presentData(response: HomeInfo.ShowInfo.Response) {
        let cards = mapCards(response.cards)
        let contacts = mapContacts(response.contacts)
        let history = mapHistory(response.history)
        
        let viewModel = HomeInfo.ShowInfo.ViewModel(displayedCards: cards, displayedContact: contacts, displayedHistory: history)
        viewController?.displayContent(viewModel: viewModel)
    }
}
