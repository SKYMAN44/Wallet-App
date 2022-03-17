//
//  Contact+CoreDataProperties.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 18.03.2022.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: Int64
    @NSManaged public var imageURL: String?

}

extension Contact : Identifiable {

}
