//
//  HomeModels.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation


enum HomeInfo {
    enum ShowInfo {
        struct Request {
            let cardIndex: Int?
        }
        
        struct Response {
            var cards: [Cards]
            var contacts: [Contacts]
            var history: [Expenses]
        }
        
        struct ViewModel {
            var displayedCards: [DisplayedCard]
            var displayedContact: [DisplayedContact]
            var displayedHistory: [DisplayedHistory]
            
            struct DisplayedCard: Hashable {
                let type: String
                let edningNumbers: String
                let balance: String
            }
            
            struct DisplayedContact: Hashable {
                let id: Int
                let imageURL: String
            }
            
            struct DisplayedHistory: Hashable {
                let recieverName: String
                let date: String
                let image: String
                let amount: String
            }
        }
    }
}
