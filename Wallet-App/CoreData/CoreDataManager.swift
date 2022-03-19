//
//  CoreDataManager.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 15.03.2022.
//

import Foundation
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistanceContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    let service = CoreDataService()
    
    // MARK: - Fetching
    public func fetchCardsInfo(completion: @escaping ([Card]) -> Void) {
        guard let container = persistanceContainer else { return }
        let descriptor = NSSortDescriptor(key: "balance", ascending: false)
        service.fetch(
            type: Card.self,
            sortDescriptors: [descriptor],
            relationshipKeysToFetch: nil,
            managedObjectContext: container.viewContext
        ) { (response) in
            switch response {
            case .success(let cards):
                completion(cards)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    public func fetchContacts(completion: @escaping ([Contact]) -> Void) {
        guard let container = persistanceContainer else { return }
        let descriptor = NSSortDescriptor(key: "id", ascending: true)
        service.fetch(
            type: Contact.self,
            sortDescriptors: [descriptor],
            relationshipKeysToFetch: nil,
            managedObjectContext: container.viewContext
        ) { (response) in
            switch response {
            case .success(let contacts):
                completion(contacts)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
//    public func fetchHistory(card: Card, completion: @escaping ([Expense]) -> Void) {
//        guard let container = persistanceContainer else { return }
//        let descriptor = NSSortDescriptor(key: "date", ascending: false)
//        service.fetch(
//            type: Expense.self,
//            sortDescriptors: [descriptor],
//            relationshipKeysToFetch: <#T##[String]?#>,
//            managedObjectContext: container.viewContext
//        ) { (response) in
//            switch response {
//            case .success(let expenses):
//                completion(expenses)
//            case .failure(let error):
//                print(error)
//                completion([])
//            }
//        }
//    }
    
    
    // MARK: - Saving
    public func saveCardsInfo(cards: [Cards]) {
        guard let container = persistanceContainer else { return }
        
        let context = container.newBackgroundContext()
        for card in cards {
            let cardCD = Card(context: context)
            cardCD.type = card.type
            cardCD.balance = card.balance
            cardCD.cardNumber = card.cardNumber
            
            if let cardHistory = card.history {
                for expense in cardHistory {
                    let expenseDB = Expense(context: context)
                    expenseDB.date = expense.date
                    expenseDB.amount = expense.amount
                    expenseDB.recieverName = expense.recieverName
                    expenseDB.setSector(expense.sector)
                    cardCD.addToExpenses(expenseDB)
                }
            }
        }
        
        service.save(managedObjectContext: context) { (response) in
            switch response {
            case .success(_):
                print("works")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func saveContacts() {
        guard let container = persistanceContainer else { return }
        service.save(managedObjectContext: container.newBackgroundContext() ) { (response) in
            switch response {
            case .success(_):
                print("works")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Deleting
    public func clearAll() {
        guard let container = persistanceContainer else { return }
        service.resetAllCoreData(persistentContainer: container)
    }
}
