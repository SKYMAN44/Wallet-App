//
//  History.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 27.02.2022.
//

import Foundation

struct Expenses {
    enum EconomicSector: Codable {
        case tech
        case grocery
        case transport
        case restaurants
        case undefined
        case intelcom
    }
    let recieverName: String
    let date: Date
    let amount: Double
    let sector: EconomicSector
}

extension Expenses: Codable { }
