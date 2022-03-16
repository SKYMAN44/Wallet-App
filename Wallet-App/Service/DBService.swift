//
//  DBService.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

// func to store fake data for later usage with actual storage 
final class DBService {
    static let shared = DBService()
    
    public func getCards() -> [Cards] {
        return [
            Cards(type: "VISA", balance: 1234, cardNumber: "5454 6969 6969 6919"),
            Cards(type: "MASTERCARD", balance: 124, cardNumber: "5494 6969 6969 6979"),
            Cards(type: "MIR", balance: 1245, cardNumber: "5474 6969 6969 6959"),
            Cards(type: "VISA", balance: 23654, cardNumber: "5444 6969 6969 7089")
        ]
    }
    
    public func getContacts() -> [Contacts] {
        return [
            Contacts(id: 1, imageURL: "testPerson.jpeg"),
            Contacts(id: 2, imageURL: "testPerson2.jpeg"),
            Contacts(id: 3, imageURL: "testPerson3.jpeg"),
            Contacts(id: 4, imageURL: "purpleGradient.jpg"),
            Contacts(id: 5, imageURL: "testPerson3.jpeg"),
            Contacts(id: 6, imageURL: "purpleGradient.jpg"),
        ]
    }
    
    public func getExpenses() -> [Expenses] {
        let stringDate = "2019-10-10"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: stringDate)
        return [
            Expenses(recieverName: "Apple Store", date: date!, amount: 8),
            Expenses(recieverName: "Creative Cloud", date: date!, amount: 1234),
            Expenses(recieverName: "Spar", date: date!, amount: 56)
        ]
    }
}
