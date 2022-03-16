//
//  HomeWorker.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation


final class HomeWorker {
    enum Const {
        static let cards = "Cards"
        static let contacts = "Contacts"
        static let expenses = "Expenses"
    }
    
    private var storageService: PersistanceStorage
    
    init(service: PersistanceStorage) {
        self.storageService = service
    }
    
    public func ChangeService(service: PersistanceStorage) {
        storageService = service
    }
    
//    public func getCards() -> [Cards] {
//        var cards: [Cards]?
//        cards = storageService.loadData(path: Const.cards)
//        if let cards = cards {
//            return cards
//        }
//        return []
//    }
    
    public func getCards(completion: @escaping ([Cards]) -> Void) {
        var resultCards = [Cards]()
        CoreDataManager.shared.fetchCardsInfo { (cards) in
            for card in cards {
                resultCards.append(Cards(type: card.type!, balance: card.balance, cardNumber: card.cardNumber!))
            }
            completion(resultCards)
        }
    }
    
    public func getContacts() -> [Contacts] {
        var contacts: [Contacts]?
        contacts = storageService.loadData(path: Const.contacts)
        if let contacts = contacts {
            return contacts
        }
        return []
    }
    
    public func getHistory() -> [Expenses] {
        var expenses: [Expenses]?
        expenses = storageService.loadData(path: Const.expenses)
        if let expenses = expenses {
            return expenses
        }
        return []
    }
}
