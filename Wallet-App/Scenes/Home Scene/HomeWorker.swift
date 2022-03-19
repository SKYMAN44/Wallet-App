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
    
    public func getCards(completion: @escaping ([Cards]) -> Void) {
        var resultCards = [Cards]()
        CoreDataManager.shared.fetchCardsInfo { (cards) in
            for card in cards {
                var history: [Expenses]?
                if let arrayOfExpensesDB = card.expenses?.allObjects as? [Expense] {
                    history = arrayOfExpensesDB.compactMap { (expense) in
                        if let name = expense.recieverName,
                           let date = expense.date {
                            return Expenses(recieverName: name, date: date, amount: expense.amount, sector: expense.getSector())
                        }
                        return nil
                    }
                }
                resultCards.append(Cards(type: card.type!, balance: card.balance, cardNumber: card.cardNumber!, history: history))
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
