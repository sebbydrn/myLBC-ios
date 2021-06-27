//
//  rtaBank.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/26/21.
//

import Foundation

// MARK: - RTA Banks
struct RtaBanks: Codable, Hashable {
    var bank_id: Int
    var code: String
    var name: String
}
