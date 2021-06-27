//
//  Signup.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/27/21.
//

import Foundation

// MARK: - Signup
struct Signup: Codable {
    let id: String
    let message: String
    let result: SignupRes
}

// MARK: - Signup Result
struct SignupRes: Codable {
    let responseCode: Int
}
