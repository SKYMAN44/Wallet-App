//
//  Expense+CoreDataProperties.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 19.03.2022.
//
//

import Foundation
import CoreData

enum EconomicSector: Int32 {
    case tech = 0
    case grocery = 1
    case transport = 2
    case restaurants = 3
    case undefined = 4
    case intelcom = 5
}

extension EconomicSector: Codable { }

extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var recieverName: String?
    @NSManaged public var sector: Int32
    @NSManaged public var card: Card?

    
    func setSector(_ sector: EconomicSector) {
        self.sector = sector.rawValue
    }
    
    func getSector() -> EconomicSector {
        return EconomicSector(rawValue: self.sector) ?? .undefined
    }
}
