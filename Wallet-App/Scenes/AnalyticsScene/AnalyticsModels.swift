//
//  AnalyticsModels.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation
import UIKit

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
            
            struct graphSegment: Hashable {
                let sectorTitle: String
                let amount: String
                let color: UIColor
                let percentage: Double
            }
            
            struct GraphStatistics: Hashable {
                let totalSum: String
                let sectors: [graphSegment]
            }
            
            var displayedHistory: [DisplayedHistory]
            var displayedGraph: GraphStatistics
        }
    }
}
