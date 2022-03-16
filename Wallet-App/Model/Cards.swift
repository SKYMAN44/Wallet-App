//
//  Cards.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

struct Cards {
    let type: String
    let balance: Double
    let cardNumber: String
}

extension Cards: Codable { }
