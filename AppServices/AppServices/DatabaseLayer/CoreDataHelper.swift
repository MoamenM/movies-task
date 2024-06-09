//
//  CoreDataHelper.swift
//  TMDbMovies
//
//  Created by ELKHADRAGI Moamen on 06/06/2024.
//

import Foundation
import CoreData

/**
 A protocol defining the required methods for interacting with a database.
 
 This protocol is generic, allowing the specification of the object type and predicate type used for database operations.
 */
public protocol DatabaseHelperProtocol {
    
    /// The type of the object being operated on.
    associatedtype ObjectType
    
    /// The type of the predicate used for fetching objects.
    associatedtype PredicateType
    
    /**
     Create an object in the database.
     
     - Parameter object: The object to be created.
     */
    func create(_ object: ObjectType)
    
    /**
     Delete an object from the database.
     
     - Parameter object: The object to be deleted.
     */
    func delete(_ object: ObjectType)
    
    /**
     Fetch objects from the database based on a given predicate.
     
     - Parameters:
        - objectType: The type of objects to fetch.
        - predicate: An optional predicate to filter the fetched objects.
        - limit: An optional limit on the number of objects to fetch.
     
     - Returns: A result containing an array of fetched objects or an error.
     */
    func fetch(_ objectType: ObjectType.Type, predicate: PredicateType?, limit: Int?) -> Result<[ObjectType], Error>
}


/**
 A helper class for interacting with Core Data.
 
 This class adopts the `DatabaseHelperProtocol` protocol and provides implementations for its methods.
 */
public class CoreDataHelper {
    
    // MARK: Properties
    
    /// The persistent container for Core Data.
    let persistentContainer: NSPersistentCloudKitContainer
    
    /// The managed object context associated with the persistent container.
    public var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    
    // MARK: Initialization
    
    /**
     Initializes the `CoreDataHelper` with the specified Core Data model name.
     
     - Parameter modelName: The name of the Core Data model.
     */
    init(modelName: String) {
        self.persistentContainer = NSPersistentCloudKitContainer(name: modelName)
        self.persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // MARK: Class methods
    
    /**
     Initializes and returns a shared instance of `CoreDataHelper` with the specified Core Data model name.
     
     - Parameter modelName: The name of the Core Data model.
     - Returns: A shared instance of `CoreDataHelper`.
     */
    public static func initializeSharedInstance(modelName: String) -> CoreDataHelper {
        return CoreDataHelper(modelName: modelName)
    }
        
    
    // MARK: Helper methods
    
    /**
     Saves changes made to the managed object context.
     
     This method should be called after making changes to the Core Data objects to persist the changes.
     */
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}


// MARK: - DatabaseHelperProtocol
extension CoreDataHelper: DatabaseHelperProtocol {
    
    /// Specifies that the object type used in Core Data operations is `NSManagedObject`.
    public typealias ObjectType = NSManagedObject
    
    /// Specifies that the predicate type used in Core Data operations is `NSPredicate`.
    public typealias PredicateType = NSPredicate
    
    /**
     Creates an object in the Core Data database.
     
     - Parameter object: The `NSManagedObject` to be created.
     */
    public func create(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch (let error){
            print("error saving context while creating an object: \(error.localizedDescription)")
        }
    }
    
    /**
     Deletes an object from the Core Data database.
     
     - Parameter object: The `NSManagedObject` to be deleted.
     */
    public func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
    
    /**
     Fetches objects from the Core Data database based on a given predicate.
     
     - Parameters:
        - objectType: The type of objects to fetch.
        - predicate: An optional predicate to filter the fetched objects.
        - limit: An optional limit on the number of objects to fetch.
     
     - Returns: A result containing an array of fetched objects or an error.
     */
    public func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, limit: Int? = nil) -> Result<[T], Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        if let limit = limit {
            request.fetchLimit = limit
        }
        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }
}
