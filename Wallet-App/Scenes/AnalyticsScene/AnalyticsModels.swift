//
//  AnalyticsModels.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation

enum AnalyticsInfo {
    enum ShowInfo {
        struct Request {
            // add historyForWhichCard
        }
        
        struct Response {
            var history: [Expenses]
        }
        
        struct ViewModel {
            struct DisplayedHistory: Hashable {
                let recieverName: String
                let date: String
                let image: String
                let amount: String
            }
            var displayedHistory: [DisplayedHistory]
        }
    }
}
