//
//  ChangePassAPI.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/27/21.
//

import Foundation

class ChangePassAPI: ObservableObject {
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
    }
    
    func changePass(currPasswd: String, newPasswd: String, completion: @escaping (String) -> ()) {
        let userToken = userAccount[0].token
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/changePassword") else { return }
        
        let body: [String: String] = ["currPasswd": currPasswd, "newPasswd": newPasswd]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(ChangePass.self, from: data)
            
            if finalData?.message == "Password has been changed!" {
                DispatchQueue.main.async {
                    // TODO: return if current password is incorrect
                    completion("Success")
                }
            } else {
                print("Cannot change password")
            }
        }.resume()
    }
}
