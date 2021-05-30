//
//  DBHelper.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 5/25/21.
//

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createUserTable()
    }
    
    let dbPath: String = "myLBC.sqlite"
    var db: OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createUserTable()
    {
        let createTableString = "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY AUTOINCREMENT, token TEXT, username TEXT, fname TEXT, mname TEXT, lname TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("User table created.")
            } else {
                print("User table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertUser(token: String, username: String, fname: String, mname: String, lname: String)
    {
//        deleteUsers()
        
        let insertStatementString = "INSERT INTO user(token, username, fname, mname, lname) VALUES (?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (token as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (fname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (mname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (lname as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row")
            } else {
                print("Could not insert row")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readUser(id: Int) -> [UserTable] {
        let queryStatementString = "SELECT * FROM user WHERE id=?;"
        var queryStatement: OpaquePointer? = nil
        var userAccount: [UserTable] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(id))
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let token = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let fname = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let mname = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let lname = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
                userAccount = [UserTable(id: Int(id), token: token, username: username, fname: fname, mname: mname, lname: lname)]
                print("Query result: \(userAccount[0].token)")
            } else {
                print("Could not read user")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return userAccount
    }
    
    func countUsers() -> Int {
        let countStatementString = "SELECT COUNT(*) FROM user;"
        var countStatement: OpaquePointer? = nil
        var count = 0
        if sqlite3_prepare_v2(db, countStatementString, -1, &countStatement, nil) == SQLITE_OK {
            while(sqlite3_step(countStatement) == SQLITE_ROW){
                count = Int(sqlite3_column_int(countStatement, 0))
                print("Query result: \(count)")
            }
        } else {
            print("COUNT statement could not be prepared")
        }
        sqlite3_finalize(countStatement)
        return count
    }
    
    func deleteUsers() {
        let deleteStatementString = "DELETE FROM user WHERE id=1;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Users deleted")
            } else {
                print("Could not delete users")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    func testFunc() {
        print("TEST FUNC")
    }
}
