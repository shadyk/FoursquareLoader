// Copyright © Shady Kahaleh. All rights reserved.

import CoreData

@objc(ManagedLocation)
class ManagedLocation: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var id: String
}


extension ManagedLocation {
    //    static func find(in context: NSManagedObjectContext) throws -> ManagedLocation? {
    //        let request = NSFetchRequest<ManagedLocation>(entityName: entity().name!)
    //        request.returnsObjectsAsFaults = false
    //        return try context.fetch(request).first
    //    }
    
    static func find(in context: NSManagedObjectContext) throws -> [ManagedLocation]? {
        let request = NSFetchRequest<ManagedLocation>(entityName: entity().name!)
        //            request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedLocation.date), date])
        request.returnsObjectsAsFaults = false
        return try context.fetch(request)
    }
    
    
    static func find(ID:String, context: NSManagedObjectContext) throws -> ManagedLocation? {
        let request = NSFetchRequest<ManagedLocation>(entityName: entity().name!)
        request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedLocation.id),ID])
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }
    static func deleteAll(context: NSManagedObjectContext){
        let fetchRequest = NSFetchRequest<ManagedLocation>(entityName: entity().name!)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for managedObject in results {
                print("delete all")
                context.delete(managedObject)
            }
        } catch let error as NSError {
            print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
        }
    }
    
    
    static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedLocation {
        //        try find(in: context).map(context.delete)
        return ManagedLocation(context: context)
    }
    
    var localLocation: LocalLocation {
        return LocalLocation(ID: "\(self.id)", name: self.name)
    }
    
    //    var localFeed: [LocalFeedImage] {
    //        return feed.compactMap { ($0 as? ManagedFeedImage)?.local }
    //    }
}
