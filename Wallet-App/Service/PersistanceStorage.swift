//
//  PersistanceStorageProtocol.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 08.03.2022.
//

import Foundation

protocol PersistanceStorage {
    func saveData<StoreItem: Codable>(data: [StoreItem], path: String)
    func loadData<StoreItem: Codable>(path: String) -> [StoreItem]?
}
