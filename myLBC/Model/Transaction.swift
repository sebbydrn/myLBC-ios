//
//  Transaction.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/20/21.
//

import Foundation

// MARK: - Transactions
struct Transactions: Codable {
    let id, message: String
    let result: TransactionResult
}

// MARK: - Result
struct TransactionResult: Codable {
    let responseCode: Int
    var postedTrx: [PostedTrx] = []
    var pendingTrx: [PendingTrx] = []
}

// MARK: - PostedTrx
struct PostedTrx: Codable, Identifiable {
    let id = UUID()
    let trx_id, wallet_id, trx_type_id: Int
    let amount: String
    let freight, cod_fee, rts, other_fees: String?
    let net_amt, service_fee, trx_ref: String
    let trx_ref_ext: String?
    let sender_id, receiver_id: Int?
    let date_posted, trxType, balance: String
    let trx_date: String
    let branch_name: String?
    let gross, netAmt: String
}

// MARK: - PendingTrx
struct PendingTrx: Codable, Identifiable {
    let id = UUID()
    let trx_id, wallet_id, trx_type_id: Int
    let amount: String
    let freight, cod_fee, rts, other_fees: String?
    let net_amt, service_fee, trx_ref: String
    let trx_ref_ext: String?
    let sender_id, receiver_id: Int?
    let date_posted, trxType, balance: String
    let trx_date: String
    let branch_name: String?
    let gross, netAmt: String
}
