//
//  HomeInteractor.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

final class HomeInteractor: HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker = HomeWorker(service: FileService())
    
    //MARK: - HomeDataStore
    var cards: [Card]?
    var contacts: [Contact]?
    var history: [Expenses]?
}

extension HomeInteractor: HomeBusinessLogic {
    func showInformation(request: HomeInfo.ShowInfo.Request) {
        let cards = worker.getCards()
        let contacts = worker.getContacts()
        let history = worker.getHistory()
        self.cards = cards
        self.contacts = contacts
        self.history = history
        let response = HomeInfo.ShowInfo.Response(cards: cards, contacts: contacts, history: history)
        presenter?.presentData(response: response)
    }
}
