//
//  Province.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/26/21.
//

import Foundation

// MARK: - Province
struct Provinces: Codable, Hashable {
    var province_id: Int
    var province_name: String
    var region: String
}
