//
//  GetBalance.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/19/21.
//

import Foundation

class balanceAPI: ObservableObject {
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    @Published var availableBalance: String = ""
    @Published var currentBalance: String = ""
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
    }
    
    func getBalance() {
        let userToken = userAccount[0].token
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/getBalance") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let welcome = try? JSONDecoder().decode(Balance.self, from: data)
            
            if welcome?.message == "Balance has been successfully retrieved" {
                DispatchQueue.main.async {
                    self.availableBalance = welcome!.result.availableBalance
                    self.currentBalance = welcome!.result.currentBalance
                    print(welcome!.result.availableBalance)
                    print(welcome!.result.currentBalance)
                }
            } else {
                print("Cannot retrieve balance")
            }
        }.resume()
    }
}
