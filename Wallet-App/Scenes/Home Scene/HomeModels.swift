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
            
        }
        
        struct Response {
            var cards: [Card]
            var contacts: [Contact]
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
            
            var displayedCards: [DisplayedCard]
            var displayedContact: [DisplayedContact]
        }
    }
    
    enum AddContact {
        
    }
}
