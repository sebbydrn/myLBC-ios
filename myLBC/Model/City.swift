//
//  City.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/26/21.
//

import Foundation

// MARK: - City
struct Cities: Codable, Hashable {
    var city_id: Int
    var city_name: String
    var province: Int
}
