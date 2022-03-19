//
//  AnalyticsPresenterTest.swift
//  Wallet-AppTests
//
//  Created by Дмитрий Соколов on 10.03.2022.
//

import XCTest
@testable import Wallet_App

class AnalyticsPresenterTest: XCTestCase {
    var presenter: AnalyticsPresenter?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        presenter = AnalyticsPresenter()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    
    // MARK: Substitution for viewController
    final class AnalyticsDisplayLogicFake: AnalyticsDisplayLogic {
        var displayFetchedContactsCalled = false
        
        var viewModel = [AnalyticsInfo.ShowInfo.ViewModel.DisplayedHistory]()
        
        func displayContent(viewModel: AnalyticsInfo.ShowInfo.ViewModel) {
            self.viewModel = viewModel.displayedHistory
            displayFetchedContactsCalled = true
        }
        
    }

    // MARK: Tests
    func testPresenterShouldFormatFetchedExpensesForDisplay() {
        let analyticsDisplayLogic = AnalyticsDisplayLogicFake()
        presenter?.viewController = analyticsDisplayLogic
        
        let expense = TestData.History.history
        let history = [expense]
        
        let response = AnalyticsInfo.ShowInfo.Response(history: history)
        presenter?.presentData(response: response)
        
        let displayedHistory = analyticsDisplayLogic.viewModel
        for expense in displayedHistory {
            XCTAssertEqual(expense.amount, "- $123.0", "Presenting fetched expenses should properly format amount")
        }
    }

}
