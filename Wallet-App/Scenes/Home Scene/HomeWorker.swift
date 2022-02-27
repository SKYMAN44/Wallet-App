//
//  HomeWorker.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation


final class HomeWorker {
    func getCards() -> [Card] {
        return DBService.shared.getCards()
    }
    
    func getContacts() -> [Contact] {
        return DBService.shared.getContacts()
    }
}
