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
        }
        
        struct ViewModel {
            struct DisplayedCard {
                let type: String
                let edningNumbers: String
                let balance: String
            }
            
            var displayedCards: [DisplayedCard]
        }
    }
    
    enum AddContact {
        
    }
}
