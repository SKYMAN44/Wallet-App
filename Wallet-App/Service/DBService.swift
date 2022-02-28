//
//  DBService.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation


final class DBService {
    static let shared = DBService()
    
    public func getCards() -> [Card] {
        return [
            Card(type: "VISA", balance: "1234", cardNumber: "5454 6969 6969 6919"),
            Card(type: "MASTERCARD", balance: "124", cardNumber: "5454 6969 6969 6979"),
            Card(type: "MIR", balance: "1245", cardNumber: "5454 6969 6969 6959"),
            Card(type: "VISA", balance: "23654", cardNumber: "5454 6969 6969 7089")
        ]
    }
    
    public func getContacts() -> [Contact] {
        return [
            Contact(id: 1, imageURL: "testPerson.jpeg"),
            Contact(id: 2, imageURL: "testPerson2.jpeg"),
            Contact(id: 3, imageURL: "testPerson3.jpeg"),
            Contact(id: 4, imageURL: "purpleGradient.jpg"),
            Contact(id: 5, imageURL: "testPerson3.jpeg"),
            Contact(id: 6, imageURL: "purpleGradient.jpg"),
        ]
    }
    
    public func getExpenses() -> [Expenses] {
        return [
            Expenses(recieverName: "Apple Store", date: "09:30 am", amount: "334"),
            Expenses(recieverName: "Creative Cloud", date: "06 Aug. 2021", amount: "1234"),
            Expenses(recieverName: "Spar", date: "07 Aug. 2021", amount: "56")
        ]
    }
}
