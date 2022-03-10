//
//  File.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 07.03.2022.
//

import Foundation

final class FileService: PersistanceStorage {
    func saveData<StoreItem>(data: [StoreItem], path: String) where StoreItem : Codable {
        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent(path).appendingPathExtension("json")
            let fileData = try JSONEncoder().encode(data)
            try fileData.write(to: storageURL)
        } catch {
            fatalError("There was a problem saving \(StoreItem.self). Error: \(error)")
        }
    }
    
    func loadData<StoreItem>(path: String) -> [StoreItem]? where StoreItem : Codable {
        var storeItems = [StoreItem]()

        do {
            let storageDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let storageURL = storageDirectory.appendingPathComponent(path).appendingPathExtension("json")
            let fileData = try Data(contentsOf: storageURL)
            storeItems = try JSONDecoder().decode([StoreItem].self, from: fileData)
        } catch {
            return nil
        }

        return storeItems
    }

}
