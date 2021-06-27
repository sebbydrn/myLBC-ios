//
//  Tracking.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/21/21.
//

import Foundation

// MARK: - Tracking
struct Tracking: Codable {
    let id: String
    let message: String
    let result: TrackingResult
}

// MARK: - Result
struct TrackingResult: Codable {
    let responseCode: Int
    var trackingHistoryDetails: [TrackingHistoryDtls] = []
}

// MARK: - Tracking History Details
struct TrackingHistoryDtls: Codable, Identifiable {
    let id = UUID()
    let DatePosted: String
    let StatusandLocation: String
    let DatePostedTime: String
    let TrackingHistoryID: String
    let Branch: BranchDtls
}

// MARK: - Branch
struct BranchDtls: Codable {
    let BranchId: String
    let BranchCode: String
    let BranchDescr: String
}
