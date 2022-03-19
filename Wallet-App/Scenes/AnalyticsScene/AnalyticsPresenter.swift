//
//  AnalyticsPresenter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation
import UIKit

final class AnalyticsPresenter: AnalyticsPresentationLogic {
    weak var viewController: AnalyticsDisplayLogic?
    
    static let ColorMap: [EconomicSector: UIColor] = [
        .restaurants: .yellow,
        .intelcom: .cyan,
        .grocery: .green,
        .tech: .purple,
        .transport: .blue,
        .undefined: .brown
    ]
    private func mapHistory(_ items: [Expenses]) -> [AnalyticsInfo.ShowInfo.ViewModel.DisplayedHistory] {
        let mapped = items.map {
            AnalyticsInfo.ShowInfo.ViewModel.DisplayedHistory(
                recieverName: $0.recieverName,
                date: $0.date.format(),
                image: "purpleGradient.jpg",
                amount: "- $" + "\($0.amount)"
            )
        }
        
        return mapped
    }

    private func mapGraph(_ items: [Expenses]) -> AnalyticsInfo.ShowInfo.ViewModel.GraphStatistics {
        let total = items.reduce(0) { $0 + $1.amount }
        
        var hashTable = [EconomicSector: [Expenses]]()
        items.forEach {
            if(hashTable[$0.sector] == nil) {
                hashTable[$0.sector] = [$0]
            } else {
                hashTable[$0.sector]?.append($0)
            }
        }
        
        var sectors = [AnalyticsInfo.ShowInfo.ViewModel.graphSegment]()
        for (eSector, sectorExpenses) in hashTable {
            let amount = sectorExpenses.reduce(0) { $0 + $1.amount }
            
            sectors.append(AnalyticsInfo.ShowInfo.ViewModel.graphSegment(
                    sectorTitle: "\(eSector)",
                    amount: "$ \(amount)",
                    color: AnalyticsPresenter.ColorMap[eSector] ?? .clear,
                    percentage: amount / total
                )
            )
        }
        sectors.sort { $0.sectorTitle > $1.sectorTitle}
        
        return AnalyticsInfo.ShowInfo.ViewModel.GraphStatistics(
            totalSum: total,
            sectors: sectors
        )
    }
    
    public func presentData(response: AnalyticsInfo.ShowInfo.Response) {
        let history = mapHistory(response.history)
        let graph = mapGraph(response.history)
        
        let viewModel = AnalyticsInfo.ShowInfo.ViewModel(displayedHistory: history, displayedGraph: graph)
        viewController?.displayContent(viewModel: viewModel)
    }
}
