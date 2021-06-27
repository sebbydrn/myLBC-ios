//
//  IdType.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/26/21.
//

import Foundation

// MARK: - ID Types
struct IdTypes: Codable, Hashable {
    let type_id: Int
    let type_name: String
    let type_desc: String
}
