//
//  ProvincesTable.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 5/26/21.
//

import Foundation

class ProvincesTable
{
    
    var id: Int = 0
    var province_id: Int = 0
    var province_name: String = ""
    var region: String = ""
    
    init(id: Int, province_id: Int, province_name: String, region: String)
    {
        self.id = id
        self.province_id = province_id
        self.province_name = province_name
        self.region = region
    }
    
}
