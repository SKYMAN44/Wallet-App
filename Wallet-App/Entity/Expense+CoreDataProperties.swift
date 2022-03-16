//
//  Expense+CoreDataProperties.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 14.03.2022.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var recieverName: String?
    @NSManaged public var card: Card?

}

extension Expense : Identifiable {

}
