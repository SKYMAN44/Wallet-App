//
//  Card+CoreDataProperties.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 18.03.2022.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var balance: Double
    @NSManaged public var cardNumber: String?
    @NSManaged public var type: String?
    @NSManaged public var expenses: NSSet?

}

// MARK: Generated accessors for expenses
extension Card {

    @objc(addExpensesObject:)
    @NSManaged public func addToExpenses(_ value: Expense)

    @objc(removeExpensesObject:)
    @NSManaged public func removeFromExpenses(_ value: Expense)

    @objc(addExpenses:)
    @NSManaged public func addToExpenses(_ values: NSSet)

    @objc(removeExpenses:)
    @NSManaged public func removeFromExpenses(_ values: NSSet)

}

extension Card : Identifiable {

}
