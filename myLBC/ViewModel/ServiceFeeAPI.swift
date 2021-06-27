//
//  ServiceFeeAPI.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/22/21.
//

import Foundation

class ServiceFeeAPI: ObservableObject {
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    @Published var serviceFee: String = "0.0"
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
    }
    
    func getServiceFee(amt: String) {
        let userToken = userAccount[0].token
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/getServiceFee") else { return }
        
        let body: [String: String] = ["amt": amt]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(ServiceFee.self, from: data)
            
            if finalData?.message == "Successfully fetched service fee" {
                DispatchQueue.main.async {
                    self.serviceFee = finalData!.result.fee
                }
            } else {
                print("Cannot retrieve service fee")
            }
        }.resume()
    }
}
