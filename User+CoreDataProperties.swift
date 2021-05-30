//
//  User+CoreDataProperties.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 5/23/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var fname: String
    @NSManaged public var lname: String
    @NSManaged public var mname: String
    @NSManaged public var token: String
    @NSManaged public var username: String

}

extension User : Identifiable {

}
