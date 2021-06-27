//
//  RTAAccountsAPI.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/28/21.
//

import Foundation

class RTAAccountsAPI: ObservableObject {
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
    }
    
    func getRTAAccts(completion: @escaping ([RTAAcctsList]) -> ()) {
        let userToken = userAccount[0].token
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/getRTAAccts") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(RTAAccounts.self, from: data)
            
            if finalData?.message == "RTA accounts have been retrieved" {
                DispatchQueue.main.async {
                    completion(finalData!.result.rtaAccts)
                }
            } else {
                print("Cannot retrieve RTA accounts")
            }
        }.resume()
    }
}
