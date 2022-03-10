//
//  CoreDataService.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 08.03.2022.
//

import Foundation
import CoreData

final class CoreDataService: PersistanceStorage {
    func saveData<StoreItem>(data: [StoreItem], path: String) where StoreItem : Decodable, StoreItem : Encodable {
        
    }
    
    func loadData<StoreItem>(path: String) -> [StoreItem]? where StoreItem : Decodable, StoreItem : Encodable {
        return []
    }

}
