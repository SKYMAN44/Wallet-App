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
            Contact(id: 1),
            Contact(id: 2),
            Contact(id: 3),
            Contact(id: 4),
            Contact(id: 5),
            Contact(id: 6),
            Contact(id: 7),
            Contact(id: 8)
        ]
    }
}
