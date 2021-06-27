//
//  ChangePass.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/27/21.
//

import Foundation

// MARK: - Change Password Return Data
struct ChangePass: Codable {
    let id: String
    let message: String
    let result: ChangePassRes
}

// MARK: - Change Password Result
struct ChangePassRes: Codable {
    let responseCode: Int
}
