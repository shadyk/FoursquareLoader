// Copyright ©  Shady Kahaleh. All rights reserved.

import Foundation

final class LocalLocationLoader{
    
    private let store: LocationStore
    
    public init(store: LocationStore) {
        self.store = store
    }
}

extension LocalLocationLoader : LocationLoader {
    
    func getLocations(location:String?, success: @escaping GetLocationCompletion, fail: @escaping ErrorHandler){
        store.retrieve() { (result) in
            switch result{
            case .success(let local):
                debugPrint("load local : \(local.map{$0.name})")
                success(local.toModels)
            case .failure(let error):
                debugPrint("load locally fail \(error)")
                fail(error.localizedDescription)
            }
            
        }
    }
}

extension LocalLocationLoader : LocationCache {
    func save(locations: [Location], completion: @escaping (CacheResult) -> Void) {
        for item in locations{
            store.deleteLocation(ID: item.ID) { result in
                switch result {
                case .success:
                    self.cache(item, with: completion)
                case .failure(let error):
                    completion(.failure(error))
                    debugPrint("\(item.name) not found to delete")
                }
            }
        }
        debugPrint("insert finished success")
    }
    
    private func cache(_ location: Location, with completion: @escaping (CacheResult) -> Void) {
        store.insert(locations: location.toLocal) { (result) in
            switch result{
            case .success():
                completion(result)
            case .failure(let error):
                debugPrint("insert finished in fail \(error)")
                completion(.failure(error))
                
            }
        }
    }
}
