//
//  CoreData.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 03.12.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import Foundation
import CoreData

class TweetsCData  {
    
    static let instance = TweetsCData.init()
    
// MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name:"TwiViewer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
// MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//MARK: - CoreData Methods
    
    func clearCD() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Tweet")
        //let description = NSEntityDescription.entity(forEntityName: "Tweet", in: persistentContainer.viewContext)
        do {
            let resultArray = try persistentContainer.viewContext.fetch(request)
            for tweet in resultArray  {
                persistentContainer.viewContext.delete(tweet as! Tweet)
                self.saveContext()
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        
    }
    
    func addObjectsToCD(tweets: [TweetModel]) {
        for tweet in tweets {
            let tweetForInsert : Tweet = NSEntityDescription.insertNewObject(forEntityName: "Tweet", into: persistentContainer.viewContext) as! Tweet

            tweetForInsert.id = tweet.id_str
            tweetForInsert.name = tweet.name
            tweetForInsert.screenName = tweet.screenName
            tweetForInsert.text = tweet.text
            tweetForInsert.image = tweet.image
            tweetForInsert.created_at = tweet.created_at as Date
            tweetForInsert.imageData = tweet.imageData as Data
            
            self.saveContext()
        }
    }
    
    func printCD() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"Tweet")
        do {
            let resultArray = try persistentContainer.viewContext.fetch(request) as! [Tweet]
            for tweet: Tweet in resultArray{
                print("Tweet ID: \(tweet.id), name: \(tweet.name), screenName: \(tweet.screenName), text: \(tweet.text) ")
                
            }
        }catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        print("\n")
    }
    
    func allObjects() -> [Tweet]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tweet")
        let sort = NSSortDescriptor(key: #keyPath(Tweet.created_at), ascending: false)
        request.sortDescriptors = [sort]
        do {
            let fetchedEntities = try persistentContainer.viewContext.fetch(request) as! [Tweet]
            return fetchedEntities
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
