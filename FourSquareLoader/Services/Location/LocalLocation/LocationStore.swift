// Copyright ©  Shady Kahaleh. All rights reserved.

import Foundation
protocol LocationStore {
    typealias InsertResult = Result<Void,Error>
    typealias RetrieveResult = Result<[LocalLocation],Error>
    
    typealias DeletionResult = Result<Void, Error>
    typealias DeletionCompletion = (DeletionResult) -> Void
    
    func insert(locations:[LocalLocation], completion: @escaping(InsertResult)->Void)
    func retrieve(completion: @escaping(RetrieveResult)->Void)
    func deleteLocation(ID:String, completion: @escaping DeletionCompletion) 
}
