//
//  CoreDataManager.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 5/23/21.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "myLBC")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    func saveUser(token: String, username: String, fname: String, mname: String, lname: String) {
        let user = User(context: persistentContainer.viewContext)
        user.token = token
        user.username = username
        user.fname = fname
        user.mname = mname
        user.lname = lname
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save user \(error)")
        }
    }
    
    func getUserDetails() -> [User] {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
    }
    
    func testFunc() {
        print("test")
    }
    
}
