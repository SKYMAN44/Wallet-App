//
//  AnalyticsPresenter.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 04.03.2022.
//

import Foundation

final class AnalyticsPresenter: AnalyticsPresentationLogic {
    weak var viewController: AnalyticsDisplayLogic?
    
    func presentData(response: AnalyticsInfo.ShowInfo.Response) {
        let mappedH = response.history.map {
            AnalyticsInfo.ShowInfo.ViewModel.DisplayedHistory(
                recieverName: $0.recieverName,
                date: $0.date,
                image: "purpleGradient.jpg",
                amount: "- $" + $0.amount
            )
        }
        let viewModel = AnalyticsInfo.ShowInfo.ViewModel(displayedHistory: mappedH)
        viewController?.displayContent(viewModel: viewModel)
    }
}
