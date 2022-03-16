//
//  Card+CoreDataProperties.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 14.03.2022.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var type: String?
    @NSManaged public var balance: Double
    @NSManaged public var cardNumber: String?
    @NSManaged public var expenses: [Expense]?

}

extension Card : Identifiable {

}
