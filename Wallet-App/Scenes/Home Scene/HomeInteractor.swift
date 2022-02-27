//
//  HomeInteractor.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

protocol HomeBusinessLogic {
    func showInformation(request: HomeInfo.ShowInfo.Request)
}

protocol HomeDataStore {
    var cards: [Card]? { get }
    var contacts: [Contact]? { get }
    var history: [Expenses]? { get }
}

final class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker = HomeWorker()
    var cards: [Card]?
    var contacts: [Contact]?
    var history: [Expenses]?
    
    func showInformation(request: HomeInfo.ShowInfo.Request) {
        let cards = worker.getCards()
        let contacts = worker.getContacts()
        self.cards = cards
        self.contacts = contacts
        let response = HomeInfo.ShowInfo.Response(cards: cards, contacts: contacts)
        presenter?.presentData(response: response)
    }
}