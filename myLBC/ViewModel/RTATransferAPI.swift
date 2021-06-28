//
//  RTATransferAPI.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/28/21.
//

import Foundation

class RTATransferAPI: ObservableObject {
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    @Published var trx: Bool = false
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
    }
    
    func rtaTransfer(
        rtaBankCode: String,
        amount: String,
        senderAcct: String,
        rtaBankBranch: String,
        rtaRcvrAcctNo: String,
        rtaRcvrFirstName: String,
        rtaRcvrLastName: String,
        rtaAcctType: String,
        rtaMobile: String,
        rtaStreet: String,
        fee: String,
        rtaRel: String,
        rtaRelDesc: String,
        rtaPurpose: String,
        rtaPurposeDesc: String,
        saveAcctFlag: String,
        completion: @escaping (String) -> ()
        ) {
        // API HAS PROBLEM FIX FIRST
        /*let userToken = userAccount[0].token
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/rtaTransfer") else { return }
        
        let body: [String: String] = ["rtaBankCode": rtaBankCode, "amount": amount, "senderAcct": senderAcct, "rtaBankBranch": rtaBankBranch, "rtaRcvrAcctNo": rtaRcvrAcctNo, "rtaRcvrFirstName": rtaRcvrFirstName, "rtaRcvrLastName": rtaRcvrLastName, "rtaAcctType": rtaAcctType, "rtaMobile": rtaMobile, "rtaStreet": rtaStreet, "fee": fee, "rtaRel": rtaRel, "rtaRelDesc": rtaRelDesc, "rtaPurpose": rtaPurpose, "rtaPurposeDesc": rtaPurposeDesc, "saveAcctFlag": saveAcctFlag]
        
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
        }.resume()*/
        completion("Success")
    }
}
