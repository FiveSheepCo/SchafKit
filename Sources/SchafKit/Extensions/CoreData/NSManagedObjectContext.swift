import Foundation

#if canImport(CoreData)
import CoreData

extension NSManagedObjectContext {
    func fetchObject<T>(with url: URL) -> T? {
        guard let coordinator = self.persistentStoreCoordinator else {
            fatalError("Unable to obtain NSPersistentStoreCoordinator.")
        }
        guard let objectId = coordinator.managedObjectID(forURIRepresentation: url) else {
            return nil
        }
        return try? self.existingObject(with: objectId) as? T
    }
}
#endif
