//
//  CashoutAPI.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/22/21.
//

import Foundation

class CashoutAPI: ObservableObject {
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    @Published var trx: Bool = false
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
    }
    
    func cashout(amount: String, fee: String, rel: String, relDesc: String, purpose: String, purposeDesc: String) {
        let userToken = userAccount[0].token
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/cashout") else { return }
        
        let body: [String: String] = ["amount": amount, "fee": fee, "rel": rel, "relDesc": relDesc, "purpose": purpose, "purposeDesc": purposeDesc]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(Cashout.self, from: data)

            if finalData?.message == "Transaction has been processed" {
                DispatchQueue.main.async {
                    self.trx = true
                    // TODO: completion of async task to trap error
                }
            } else {
                print("Cannot process transaction")
            }
        }.resume()
    }
}
