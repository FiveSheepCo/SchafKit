//  Copyright (c) 2015 - 2019 Jann Schafranek
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#if canImport(CoreData)
import CoreData

public extension NSManagedObjectContext {
    
    /**
     Saves the receiver throwing a fatalError if the save fails.
    
     - parameter errorHandler : When an error occurs this is called so you can potentially fix it. If it returns true, no fatalError is thrown.
    */
    func saveThrowingError(errorHandler : ((Error)->Bool)? = nil) {
        if self.hasChanges {
            do {
                try self.save()
            } catch {
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                // But:
                // Letting the user continue to use the app in a state where this error persists will be destructive to any changes the user makes going forward.
                
                if errorHandler?(error) == true {
                    return
                }
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    /**
     Returns all objects matching the given parameters.
     
     - parameters:
     - entityType : The type of the Entity.
     - predicates : The predicates to use.
     - sortDescriptors : The sort descriptors to use.
     - limit : The maximum number of items to fetch.
     - includesSubentities : Whether subentities should be included. The default value is true.
     */
    func getAllObjects<T : NSManagedObject>(of entityType: T.Type,
                                                   predicates: [NSPredicate]? = nil,
                                                   sortDescriptors: [NSSortDescriptor]? = nil,
                                                   limit: Int? = nil,
                                                   includesSubentities: Bool = true) -> [T] {
        return getAllObjects(with: String(describing: entityType),
                             predicates: predicates,
                             sortDescriptors: sortDescriptors,
                             limit: limit,
                             includesSubentities: includesSubentities) as! [T]
    }
    
    /**
     Returns all objects matching the given parameters.
    
     - parameters:
         - entityString : The string identifying the Entity.
         - predicates : The predicates to use.
         - sortDescriptors : The sort descriptors to use.
         - limit : The maximum number of items to fetch.
         - includesSubentities : Whether subentities should be included. The default value is true.
    */
    func getAllObjects(with entityString : String, predicates:[NSPredicate]?, sortDescriptors:[NSSortDescriptor]?, limit : Int? = nil, includesSubentities : Bool = true) -> [NSManagedObject]{
        var toReturn : [NSManagedObject] = []
        
        self.retrieveFetchRequestAndWait(with: entityString, predicates: predicates, sortDescriptors: sortDescriptors, limit: limit, includesSubentities: includesSubentities, handler: { request in
            do {
                toReturn = try fetch(request) as! [NSManagedObject]
            }
            catch let err as NSError {
                NSLog("Error getting all object with entityString(%@): %@", entityString, err)
            }
        })
        
        return toReturn
    }
    
    /**
     Returns the count of all objects matching the given parameters.
     
     - parameters:
     - entityType : The type of the Entity.
     - predicates : The predicates to use.
     - sortDescriptors : The sort descriptors to use.
     - limit : The maximum number of items to fetch.
     - includesSubentities : Whether subentities should be included. The default value is true.
     */
    func getCountOfObjects<T : NSManagedObject>(of entityType: T.Type,
                                                       predicates: [NSPredicate]? = nil,
                                                       sortDescriptors: [NSSortDescriptor]? = nil,
                                                       limit: Int? = nil,
                                                       includesSubentities: Bool = true) -> Int? {
        return getCountOfObjects(with: String(describing: entityType),
                                 predicates: predicates,
                                 sortDescriptors: sortDescriptors,
                                 limit: limit,
                                 includesSubentities: includesSubentities)
    }
    
    /**
     Returns the count of all objects matching the given parameters.
    
     - parameters:
         - entityString : The string identifying the Entity.
         - predicates : The predicates to use.
         - sortDescriptors : The sort descriptors to use.
         - limit : The maximum number of items to fetch.
         - includesSubentities : Whether subentities should be included. The default value is true.
    */
    func getCountOfObjects(with entityString : String, predicates:[NSPredicate]?, sortDescriptors:[NSSortDescriptor]? = nil, limit : Int? = nil, includesSubentities : Bool = true) -> Int?{
        var toReturn : Int? = nil
        
        self.retrieveFetchRequestAndWait(with: entityString, predicates: predicates, sortDescriptors: sortDescriptors, limit: limit, includesSubentities: includesSubentities, handler: { request in
            do {
                toReturn = try count(for: request)
            }
            catch let err as NSError {
                NSLog("Error getting all object with entityString(%@): %@", entityString, err)
            }
        })
        
        return toReturn
    }
    
    /**
     Deletes all objects matching the given parameters.
     
     - parameters:
     - entityType : The string identifying the Entity.
     - predicates : The predicates to use.
     - sortDescriptors : The sort descriptors to use.
     - limit : The maximum number of items to fetch.
     - includesSubentities : Whether subentities should be included. The default value is true.
     */
    func deleteAllObjects(with entityString: String,
                                 predicates: [NSPredicate]? = nil,
                                 sortDescriptors: [NSSortDescriptor]? = nil,
                                 limit: Int? = nil,
                                 includesSubentities: Bool = true) {
        self.retrieveFetchRequestAndWait(with: entityString, predicates: predicates, sortDescriptors: sortDescriptors, limit: limit, includesSubentities: includesSubentities, handler: { request in
            do {
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
                try self.execute(deleteRequest)
            }
            catch let err as NSError {
                NSLog("Error deleting all object with entityString(%@): %@", entityString, err)
            }
        })
    }
    
    /**
     Deletes all objects matching the given parameters.
     
     - parameters:
     - entityType : The type of the Entity.
     - predicates : The predicates to use.
     - sortDescriptors : The sort descriptors to use.
     - limit : The maximum number of items to fetch.
     - includesSubentities : Whether subentities should be included. The default value is true.
     */
    func deleteAllObjects<T : NSManagedObject>(of entityType: T.Type,
                                                      predicates: [NSPredicate]? = nil,
                                                      sortDescriptors: [NSSortDescriptor]? = nil,
                                                      limit: Int? = nil,
                                                      includesSubentities: Bool = true) {
        deleteAllObjects(with: String(describing: entityType),
                         predicates: predicates,
                         sortDescriptors: sortDescriptors,
                         limit: limit,
                         includesSubentities: includesSubentities)
    }
    
    private func retrieveFetchRequestAndWait(with entityString: String,
                                             predicates: [NSPredicate]?,
                                             sortDescriptors: [NSSortDescriptor]?,
                                             limit: Int?,
                                             includesSubentities: Bool,
                                             handler : (NSFetchRequest<NSFetchRequestResult>) -> Void) {
        self.performAndWait({
            if let entityDescription : NSEntityDescription = NSEntityDescription.entity(forEntityName: entityString, in: self){
                let request = NSFetchRequest<NSFetchRequestResult>()
                request.entity = entityDescription
                request.includesSubentities = includesSubentities
                if let predicates = predicates {
                    request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
                }
                if let sortDescriptors = sortDescriptors {
                    request.sortDescriptors = sortDescriptors
                }
                if let limit = limit {
                    request.fetchLimit = limit
                }
                handler(request)
            }
        })
    }
}

#endif
