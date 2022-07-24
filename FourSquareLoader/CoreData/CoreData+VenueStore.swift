// Copyright © Shady Kahaleh. All rights reserved.

import Foundation

extension CoreDataStore : LocationStore {
    
    func insert(locations: [LocalLocation], completion: @escaping (InsertResult) -> Void) {
        debugPrint("saving \(locations.count) locations")
        for item in locations {
            self.insert(location: item, completion: completion)
        }
    }
    
    private func insert(location item: LocalLocation,completion: @escaping (InsertResult) -> Void){
        perform { context in
            completion( InsertResult{

                let managedLocation = try ManagedLocation.newUniqueInstance(in: context)
                managedLocation.id = item.ID
                managedLocation.name = item.name
                debugPrint("saving \(managedLocation.name) ")
                try context.save()
            })
        }
    }
    
    func retrieve(completion: @escaping (RetrieveResult) -> Void) {
        perform { context in
                completion(RetrieveResult {
                    try ManagedLocation.find(in: context)!.map{
                        $0.localLocation
                    }
                })
        }
    }
    
    //MARK : - DELETE
    
    func deleteLocation(ID:String, completion: @escaping DeletionCompletion) {
        perform { context in
            completion(Result {
                try ManagedLocation.find(ID:ID, context: context).map(context.delete).map(context.save)
            })
        }
    }
    
    func deleteAllLocation(completion: @escaping DeletionCompletion) {
        perform { context in
            completion(Result {
                ManagedLocation.deleteAll(context: context)
            })
        }
    }
}
