//
//  DictionaryAPI.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/26/21.
//

import Foundation

class DictionaryAPI: ObservableObject {
    func loadDictionaries() {
        var provinces: [Provinces] = []
        var cities: [Cities] = []
        var cStatus: [CivilStatus] = []
        var gender: [Gender] = []
        var nationalities: [Nationality] = []
        var idTypes: [IdTypes] = []
        var suffix: [Suffix] = []
        var rtaBanks: [RtaBanks] = []
        var rtaAcctTypes: [RtaAcctTypes] = []
        var rtaCutoffMsgs: [RtaCutoffMsgs] = []
        var count = 0
        
        var db:DBHelper = DBHelper()
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/loadDictionaries") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(DictionariesWelcome.self, from: data)
            
            if finalData?.message == "Successfully retrieved the dictionaries!" {
                DispatchQueue.main.async {
                    provinces = finalData!.result.dictionaries.provinces
                    cities = finalData!.result.dictionaries.cities
                    cStatus = finalData!.result.dictionaries.cStatus
                    gender = finalData!.result.dictionaries.gender
                    nationalities = finalData!.result.dictionaries.nationalities
                    idTypes = finalData!.result.dictionaries.idTypes
                    suffix = finalData!.result.dictionaries.suffix
                    rtaBanks = finalData!.result.dictionaries.rtaBanks
                    rtaAcctTypes = finalData!.result.dictionaries.rtaAcctTypes
                    rtaCutoffMsgs = finalData!.result.dictionaries.rtaCutoffMsgs
                    
                    // Create provinces table
                    db.createProvincesTable()
                    
                    // Save provinces to database
                    count = 0
                    
                    while count < provinces.count {
                        db.insertProvince(province_id: provinces[count].province_id, province_name: provinces[count].province_name, region: provinces[count].region)
                        count += 1
                    }
                    
                    // Create cities table
                    db.createCitiesTable()
                    
                    // Save cities to database
                    count = 0
                    
                    while count < cities.count {
                        db.insertCity(city_id: cities[count].city_id, city_name: cities[count].city_name, province: cities[count].province)
                        count += 1
                    }
                    
                    // Create civil status table
                    db.createCivilStatusTable()
                    
                    // Save civil status to database
                    count = 0
                    
                    while count < cStatus.count {
                        db.insertCivilStatus(status_id: cStatus[count].status_id, status_name: cStatus[count].status_name)
                        count += 1
                    }
                    
                    // Create gender table
                    db.createGenderTable()
                    
                    // Save gender to database
                    count = 0
                    
                    while count < gender.count {
                        db.insertGender(gender_id: gender[count].gender_id, gender_name: gender[count].gender_name)
                        count += 1
                    }
                    
                    // Create nationalities table
                    db.createNationalitiesTable()
                    
                    // Save nationalities to database
                    count = 0
                    
                    while count < nationalities.count {
                        db.insertNationality(nationality_id: count+1, nationality_name: nationalities[count].nationality_name)
                        count += 1
                    }
                    
                    // Create ID types table
                    db.createIdTypesTable()
                    
                    // Save ID types to database
                    count = 0
                    
                    while count < idTypes.count {
                        db.insertIdTypes(type_id: idTypes[count].type_id, type_name: idTypes[count].type_name, type_desc: idTypes[count].type_desc)
                        count += 1
                    }
                    
                    // Create Suffix table
                    db.createSuffixTable()
                    
                    // Save suffix to database
                    count = 0
                    
                    while count < suffix.count {
                        db.insertSuffix(suffix_id: suffix[count].suffix_id, suffix: suffix[count].suffix, description: suffix[count].description)
                        count += 1
                    }
                    
                    // Create RTA Banks table
                    db.createRtaBanksTable()
                    
                    // Save RTA Banks to database
                    count = 0
                    
                    while count < rtaBanks.count {
                        db.insertRtaBanks(bank_id: rtaBanks[count].bank_id, code: rtaBanks[count].code, name: rtaBanks[count].name)
                        count += 1
                    }
                    
                    // Create RTA Account Types table
                    db.createRtaAcctTypesTable()
                    
                    // Save RTA Account Types to database
                    count = 0
                    
                    while count < rtaAcctTypes.count {
                        db.insertRtaAcctTypes(rta_type_id: rtaAcctTypes[count].rta_type_id, name: rtaAcctTypes[count].name)
                        count += 1
                    }
                    
                    // Create RTA Cutoff Messages table
                    db.createRtaCutoffMsgsTable()
                    
                    // Save RTA Cutoff Messages to database
                    count = 0
                    
                    while count < rtaCutoffMsgs.count {
                        db.insertRtaCutoffMsgs(config_id: rtaCutoffMsgs[count].config_id, property_set: rtaCutoffMsgs[count].property_set, property: rtaCutoffMsgs[count].property, value: rtaCutoffMsgs[count].value)
                        count += 1 
                    }
                }
            } else {
                print("Cannot load the dictionaries")
            }
        }.resume()
        
    }
}
