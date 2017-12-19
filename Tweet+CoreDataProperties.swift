//
//  Tweet+CoreDataProperties.swift
//  
//
//  Created by Alex S. on 19.12.2017.
//
//

import Foundation
import CoreData


extension Tweet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tweet> {
        return NSFetchRequest<Tweet>(entityName: "Tweet")
    }

    @NSManaged public var created_at: NSDate?
    @NSManaged public var id: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var screenName: String?
    @NSManaged public var text: String?
    @NSManaged public var imageData: NSData?

}
