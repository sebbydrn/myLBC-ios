//
//  Cashout.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/22/21.
//

import Foundation

// MARK: - Cashout
struct Cashout: Codable {
    let id: String
    let message: String
    let result: CashoutResult
}

// MARK: - CashoutResult
struct CashoutResult: Codable {
    let responseCode: Int
    let trxRef: String
}
