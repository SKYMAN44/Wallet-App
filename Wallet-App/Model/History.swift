//
//  History.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

struct Expenses {
    let recieverName: String
    let date: Date
    let amount: Double
}

extension Expenses: Codable { }
