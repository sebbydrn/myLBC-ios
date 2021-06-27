//
//  ServiceFee.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/22/21.
//

import Foundation

// MARK: - ServiceFee
struct ServiceFee: Codable {
    let id: String
    let message: String
    let result: ServiceFeeResult
}

// MARK: - ServiceFeeResult
struct ServiceFeeResult: Codable {
    let responseCode: Int
    let fee: String
}
