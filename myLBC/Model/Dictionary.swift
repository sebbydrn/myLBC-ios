//
//  Dictionary.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/26/21.
//

import Foundation

// MARK: - Dictionary Welcome
struct DictionariesWelcome: Codable {
    let id: String
    let message: String
    let result: DictionaryResult
}

// MARK: - Dictionary Result
struct DictionaryResult: Codable {
    let responseCode: Int
    let dictionaries: Dictionaries
}

// MARK: - Dictionaries
struct Dictionaries: Codable {
    let provinces: [Provinces]
    let cities: [Cities]
    let cStatus: [CivilStatus]
    let gender: [Gender]
    let nationalities: [Nationality]
    let idTypes: [IdTypes]
    let suffix: [Suffix]
    let rtaBanks: [RtaBanks]
    let rtaAcctTypes: [RtaAcctTypes]
    let rtaCutoffMsgs: [RtaCutoffMsgs]
}
