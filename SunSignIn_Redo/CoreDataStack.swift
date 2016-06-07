//
//  CoreDataStack.swift
//  SunSignIn_Redo
//
//  Created by Jennifer Duffey on 5/13/16.
//  Copyright © 2016 Jennifer Duffey. All rights reserved.
//

import CoreData

class CoreDataStack
{
    let modelName = "Event"
    
    lazy var context: NSManagedObjectContext =
    {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = self.persistentStore
        
        return managedObjectContext
    }()
    
    private lazy var persistentStore: NSPersistentStoreCoordinator =
    {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent(self.modelName)
        
        do
        {
            let options = [NSMigratePersistentStoresAutomaticallyOption : true]
            
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
        }
        catch
        {
            print("Error adding persistent store")
        }
        
        return coordinator
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel =
    {
        let modelURL = NSBundle.mainBundle().URLForResource(self.modelName, withExtension: "momd")!
        
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    private lazy var applicationDocumentsDirectory: NSURL =
    {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        return urls[urls.count - 1]
    }()
    
    func saveContext()
    {
        if self.context.hasChanges
        {
            do
            {
                try self.context.save()
            }
            catch let error as NSError
            {
                print("Error: \(error.localizedDescription)")
                abort()
            }
        }
    }
}