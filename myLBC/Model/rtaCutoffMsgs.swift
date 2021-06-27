//
//  rtaCutoffMsgs.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/26/21.
//

import Foundation

// MARK: RTA Cutoff Messages
struct RtaCutoffMsgs: Codable {
    let config_id: Int
    let property_set: String
    let property: String
    let value: String
}
