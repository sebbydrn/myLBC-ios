//
//  RTAAccounts.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/27/21.
//

import Foundation

// MARK: - RTA Accounts
struct RTAAccounts: Codable {
    let id: String
    let message: String
    let result: RTAAcctsRes
}

// MARK: - RTA Accounts Result
struct RTAAcctsRes: Codable {
    let responseCode: Int
    var rtaAccts: [RTAAcctsList] = []
}

// MARK: - RTA Accounts List
struct RTAAcctsList: Codable, Identifiable {
    let id = UUID()
    let rta_acct_id: Int
    let auth_id: Int
    let bank_id: Int
    let bank_branch: String
    let consignee_fname: String
    let consignee_lname: String
    let consignee_acct_no: String
    let consignee_acct_type: Int
    let consignee_mobile: String
    let consignee_street: String?
    let bankCode: String
    let bankName: String
    let acctType: String
}
