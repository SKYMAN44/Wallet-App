//
//  TestData.swift
//  Wallet-AppTests
//
//  Created by Дмитрий Соколов on 10.03.2022.
//

import Foundation
@testable import Wallet_App

struct TestData {
    struct History {
        static let history = Expenses(recieverName: "App Store", date: Date(), amount: 123, sector: .tech)
    }
}
