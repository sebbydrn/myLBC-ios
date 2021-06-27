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
    
    // MARK: - Create User Table
    func createUserTable()
    {
        let createTableString = "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY AUTOINCREMENT, token TEXT, username TEXT, fname TEXT, mname TEXT, lname TEXT, birthdate TEXT, nationality TEXT, email TEXT, gender INTEGER);"
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
    
    // MARK: - Insert User
    func insertUser(token: String, username: String, fname: String, mname: String, lname: String, birthdate: String, nationality: String, email: String, gender: Int)
    {
//        deleteUsers()
        
        let insertStatementString = "INSERT INTO user(token, username, fname, mname, lname, birthdate, nationality, email, gender) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (token as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (fname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (mname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (lname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (birthdate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (nationality as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 9, Int32(gender))
            
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
    
    // MARK: - Read User
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
                let birthdate = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let nationality = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let gender = Int(sqlite3_column_int(queryStatement, 9))
                
                userAccount = [
                    UserTable(
                        id: Int(id),
                        token: token,
                        username: username,
                        fname: fname,
                        mname: mname,
                        lname: lname,
                        birthdate: birthdate,
                        nationality: nationality,
                        email: email,
                        gender: Int(gender)
                    )]
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
    
    // MARK: - Count Users
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
    
    // MARK: - Delete Users
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
    
    // MARK: - Create Provinces Table
    func createProvincesTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS provinces(province_id INTEGER PRIMARY KEY, province_name TEXT, region TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Provinces table created.")
            } else {
                print("Provinces table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert Province
    func insertProvince(province_id: Int, province_name: String, region: String) {
        let insertStatementString = "INSERT INTO provinces(province_id, province_name, region) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(province_id))
            sqlite3_bind_text(insertStatement, 2, (province_name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (region as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into provinces")
            } else {
                print("Could not insert row into provinces")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Get Provinces
    func getProvinces() -> [Provinces] {
        let queryStatementString = "SELECT * FROM provinces;"
        var queryStatement: OpaquePointer? = nil
        var provinces: [Provinces] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let province_id = sqlite3_column_int(queryStatement, 0)
                let province_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let region = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                provinces.append(Provinces(province_id: Int(province_id), province_name: province_name, region: region))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return provinces
    }
    
    // MARK: - Create Cities Table
    func createCitiesTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS cities(city_id INTEGER PRIMARY KEY, city_name TEXT, province INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Cities table created.")
            } else {
                print("Cities table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert City
    func insertCity(city_id: Int, city_name: String, province: Int) {
        let insertStatementString = "INSERT INTO cities(city_id, city_name, province) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(city_id))
            sqlite3_bind_text(insertStatement, 2, (city_name as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(province))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into cities")
            } else {
                print("Could not insert row into cities")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Get City
    func getCity(province_id: Int) -> [Cities] {
        let queryStatementString = "SELECT * FROM cities WHERE province=?;"
        var queryStatement: OpaquePointer? = nil
        var cities: [Cities] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(province_id))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let city_id = sqlite3_column_int(queryStatement, 0)
                let city_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let province = sqlite3_column_int(queryStatement, 3)
                
                cities.append(Cities(city_id: Int(city_id), city_name: city_name, province: Int(province)))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return cities
    }
    
    // MARK: - Create Civil Status Table
    func createCivilStatusTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS civil_status(status_id INTEGER PRIMARY KEY, status_name TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Civil status table created.")
            } else {
                print("Civil status table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert Civil Status
    func insertCivilStatus(status_id: Int, status_name: String) {
        let insertStatementString = "INSERT INTO civil_status(status_id, status_name) VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(status_id))
            sqlite3_bind_text(insertStatement, 2, (status_name as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into civil status")
            } else {
                print("Could not insert row into civil status")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Get Civil Status
    func getCivilStatus() -> [CivilStatus] {
        let queryStatementString = "SELECT * FROM civil_status;"
        var queryStatement: OpaquePointer? = nil
        var civilstatuses: [CivilStatus] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let status_id = sqlite3_column_int(queryStatement, 0)
                let status_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                
                civilstatuses.append(CivilStatus(status_id: Int(status_id), status_name: status_name))
                
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return civilstatuses
    }
    
    // MARK: - Create Gender Table
    func createGenderTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS gender(gender_id INTEGER PRIMARY KEY, gender_name TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Gender table created.")
            } else {
                print("Gender table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert Gender
    func insertGender(gender_id: Int, gender_name: String) {
        let insertStatementString = "INSERT INTO gender(gender_id, gender_name) VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(gender_id))
            sqlite3_bind_text(insertStatement, 2, (gender_name as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into gender")
            } else {
                print("Could not insert row into gender")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Get Gender
    func getGender() -> [Gender] {
        let queryStatementString = "SELECT * FROM gender;"
        var queryStatement: OpaquePointer? = nil
        var genders: [Gender] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let gender_id = sqlite3_column_int(queryStatement, 0)
                let gender_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                
                genders.append(Gender(gender_id: Int(gender_id), gender_name: gender_name))
                
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return genders
    }
    
    // MARK: - Create Nationalities Table
    func createNationalitiesTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS nationalities(nationality_id INTEGER PRIMARY KEY, nationality_name TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Nationalities table created.")
            } else {
                print("Nationalities table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert Nationality
    func insertNationality(nationality_id: Int, nationality_name: String) {
        let insertStatementString = "INSERT INTO nationalities(nationality_id, nationality_name) VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(nationality_id))
            sqlite3_bind_text(insertStatement, 2, (nationality_name as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into nationalities")
            } else {
                print("Could not insert row into nationalities")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Get Nationality
    func getNationality() -> [Nationality] {
        let queryStatementString = "SELECT * FROM nationalities;"
        var queryStatement: OpaquePointer? = nil
        var nationalities: [Nationality] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let nationality_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                
                nationalities.append(Nationality(nationality_name: nationality_name))
                
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return nationalities
    }
    
    // MARK: - Create ID Types Table
    func createIdTypesTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS id_types(type_id INTEGER PRIMARY KEY, type_name TEXT, type_desc TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("ID Types table created.")
            } else {
                print("ID Types table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert ID Types
    func insertIdTypes(type_id: Int, type_name: String, type_desc: String) {
        let insertStatementString = "INSERT INTO id_types(type_id, type_name, type_desc) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(type_id))
            sqlite3_bind_text(insertStatement, 2, (type_name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (type_desc as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into id types")
            } else {
                print("Could not insert row into id types")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Get ID Types
    func getIdTypes() -> [IdTypes] {
        let queryStatementString = "SELECT * FROM id_types;"
        var queryStatement: OpaquePointer? = nil
        var idTypes: [IdTypes] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let type_id = sqlite3_column_int(queryStatement, 0)
                let type_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let type_desc = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                idTypes.append(IdTypes(type_id: Int(type_id), type_name: type_name, type_desc: type_desc))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return idTypes
    }
    
    // MARK: - Create Suffix Table
    func createSuffixTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS suffix(suffix_id INTEGER PRIMARY KEY, suffix TEXT, description TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("Suffix table created.")
            } else {
                print("Suffix table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert Suffix
    func insertSuffix(suffix_id: Int, suffix: String, description: String) {
        let insertStatementString = "INSERT INTO suffix(suffix_id, suffix, description) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(suffix_id))
            sqlite3_bind_text(insertStatement, 2, (suffix as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (description as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into suffix")
            } else {
                print("Could not insert row into suffix")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Get Suffix
    func getSuffix() -> [Suffix] {
        let queryStatementString = "SELECT * FROM suffix;"
        var queryStatement: OpaquePointer? = nil
        var suffixes: [Suffix] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let suffix_id = sqlite3_column_int(queryStatement, 0)
                let suffix = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let description = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                suffixes.append(Suffix(suffix_id: Int(suffix_id), suffix: suffix, description: description))
                
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return suffixes
    }
    
    // MARK: - Create RTA Banks Table
    func createRtaBanksTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS rta_banks(bank_id INTEGER PRIMARY KEY, code TEXT, name TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("RTA Banks table created.")
            } else {
                print("RTA Banks table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert RTA Banks
    func insertRtaBanks(bank_id: Int, code: String, name: String) {
        let insertStatementString = "INSERT INTO rta_banks(bank_id, code, name) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(bank_id))
            sqlite3_bind_text(insertStatement, 2, (code as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (name as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into RTA Banks")
            } else {
                print("Could not insert row into RTA Banks")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Get RTA Banks
    func getRTABanks() -> [RtaBanks] {
        let queryStatementString = "SELECT * FROM rta_banks;"
        var queryStatement: OpaquePointer? = nil
        var rtaBanks: [RtaBanks] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let bank_id = sqlite3_column_int(queryStatement, 0)
                let code = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                
                rtaBanks.append(RtaBanks(bank_id: Int(bank_id), code: code, name: name))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return rtaBanks
    }
    
    // MARK: - Create RTA Account Types Table
    func createRtaAcctTypesTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS rta_acct_types(rta_type_id INTEGER PRIMARY KEY, name TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("RTA Account Types table created.")
            } else {
                print("RTA Account Types table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert RTA Account Types
    func insertRtaAcctTypes(rta_type_id: Int, name: String) {
        let insertStatementString = "INSERT INTO rta_acct_types(rta_type_id, name) VALUES (?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(rta_type_id))
            sqlite3_bind_text(insertStatement, 2, (name as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into RTA Account Types")
            } else {
                print("Could not insert row into RTA Account Types")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Get RTA Account Types
    func getRTAAcctTypes() -> [RtaAcctTypes] {
        let queryStatementString = "SELECT * FROM rta_acct_types;"
        var queryStatement: OpaquePointer? = nil
        var rtaAcctTypes: [RtaAcctTypes] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let rta_type_id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                
                rtaAcctTypes.append(RtaAcctTypes(rta_type_id: Int(rta_type_id), name: name))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        
        sqlite3_finalize(queryStatement)
        return rtaAcctTypes
    }
    
    // MARK: - Create RTA Cutoff Messages Table
    func createRtaCutoffMsgsTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS rta_cutoff_msgs(config_id INTEGER PRIMARY KEY, property_set TEXT, property TEXT, value TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("RTA Cutoff Messages table created.")
            } else {
                print("RTA Cutoff Messages table could not be created")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert RTA Cutoff Messages
    func insertRtaCutoffMsgs(config_id: Int, property_set: String, property: String, value: String) {
        let insertStatementString = "INSERT INTO rta_cutoff_msgs(config_id, property_set, property, value) VALUES (?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(config_id))
            sqlite3_bind_text(insertStatement, 2, (property_set as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (property as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (value as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row into RTA Cutoff Messages")
            } else {
                print("Could not insert row into RTA Cutoff Messages")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
}
