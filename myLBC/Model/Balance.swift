//
//  Balance.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/20/21.
//

import Foundation

// MARK: - Balance
struct Balance: Codable {
    let id, message: String
    let result: BalanceResult
}

// MARK: - Result
struct BalanceResult: Codable {
    let responseCode: Int
    let availableBalance, currentBalance: String
}
