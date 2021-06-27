//
//  TransactionAPI.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/20/21.
//

import Foundation

class TransactionAPI: ObservableObject {
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
    }
    
    func getPostedTransactions(completion: @escaping ([PostedTrx]) -> ()) {
        let userToken = userAccount[0].token
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/getTransactions") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(Transactions.self, from: data)
            
            if finalData?.message == "Transactions have been retrieved" {
                DispatchQueue.main.async {
                    completion(finalData!.result.postedTrx)
                }
            } else {
                print("Cannot retrieve transactions")
            }
        }.resume()
    }
    
    func getPendingTransactions(completion: @escaping ([PendingTrx]) -> ()) {
        let userToken = userAccount[0].token
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/getTransactions") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(Transactions.self, from: data)

            if finalData?.message == "Transactions have been retrieved" {
                DispatchQueue.main.async {
                    completion(finalData!.result.pendingTrx)
                }
            } else {
                print("Cannot retrieve transactions")
            }
        }.resume()
    }
}
