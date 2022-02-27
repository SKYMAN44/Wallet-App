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
            // add historyForWhichCard
        }
        
        struct Response {
            var cards: [Card]
            var contacts: [Contact]
            var history: [Expenses]
        }
        
        struct ViewModel {
            struct DisplayedCard: Hashable {
                let type: String
                let edningNumbers: String
                let balance: String
            }
            
            struct DisplayedContact: Hashable {
                let id: Int
            }
            
            struct DisplayedHistory: Hashable {
                let recieverName: String
                let date: String
                let image: String
                let amount: String
            }
            
            var displayedCards: [DisplayedCard]
            var displayedContact: [DisplayedContact]
            var displayedHistory: [DisplayedHistory]
        }
    }
    
    enum AddContact {
        
    }
}
