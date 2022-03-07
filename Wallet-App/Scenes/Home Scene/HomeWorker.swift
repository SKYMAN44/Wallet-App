//
//  HomeWorker.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation


final class HomeWorker {
    private var storageService: PersistanceStorage
    
    init(service: PersistanceStorage) {
        self.storageService = service
    }
    
    public func ChangeService(service: PersistanceStorage) {
        storageService = service
    }
    
    public func getCards() -> [Card] {
        var cards: [Card]?
        cards = storageService.loadData(path: "Cards")
        if let cards = cards {
            return cards
        }
        return []
    }
    
    public func getContacts() -> [Contact] {
        var contacts: [Contact]?
        contacts = storageService.loadData(path: "Contacts")
        if let contacts = contacts {
            return contacts
        }
        return []
    }
    
    public func getHistory() -> [Expenses] {
        var expenses: [Expenses]?
        expenses = storageService.loadData(path: "Expenses")
        if let expenses = expenses {
            return expenses
        }
        return []
    }
}
