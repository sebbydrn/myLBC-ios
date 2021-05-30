//
//  UserTable.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 5/25/21.
//

import Foundation

class UserTable
{
    
    var id: Int = 0
    var token: String = ""
    var username: String = ""
    var fname: String = ""
    var mname: String = ""
    var lname: String = ""
    
    init(id: Int, token: String, username: String, fname: String, mname: String, lname: String)
    {
        self.id = id
        self.token = token
        self.username = username
        self.fname = fname
        self.mname = mname
        self.lname = lname
    }
    
}
