//
//  CoreDataService.swift
//  Wallet-App
//
//  Created by Дмитрий Соколов on 14.03.2022.
//

import Foundation
import CoreData

final class CoreDataService {
    enum CoreDataError: Error {
        case failedToSave
        case failedToFetch
    }
    
    func fetch<T>(
        type: T.Type,
        sortDescriptors: [NSSortDescriptor]?,
        relationshipKeysToFetch: [String]?,
        managedObjectContext: NSManagedObjectContext,
        completion: @escaping (Result<[T], CoreDataError>) -> Void
    ) {
        managedObjectContext.perform {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: type))
            if let sortDescriptors = sortDescriptors {
                request.sortDescriptors = sortDescriptors
            }
            if let relationshipKeysToFetch = relationshipKeysToFetch {
                request.relationshipKeyPathsForPrefetching = relationshipKeysToFetch
            }
            do {
                let result = try managedObjectContext.fetch(request)
                completion(.success(result as! [T]))
            } catch {
                completion(.failure(CoreDataError.failedToFetch))
            }
        }
    }
    
    func save(
        managedObjectContext: NSManagedObjectContext,
        completion: @escaping (Result<String, CoreDataError>) -> Void
    ) {
        do {
            try managedObjectContext.save()
            completion(.failure(CoreDataError.failedToSave))
        } catch {
            completion(.success("Works"))
        }
    }
    
    func resetAllCoreData(persistentContainer: NSPersistentContainer) {
         // get all entities and loop over them
        let context = persistentContainer.viewContext
         let entityNames = persistentContainer.managedObjectModel.entities.map({ $0.name!})
         entityNames.forEach { entityName in
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

            do {
                try context.execute(deleteRequest)
                try context.save()
            } catch {
                // error
                fatalError("Can't clear db")
            }
        }
    }
}
