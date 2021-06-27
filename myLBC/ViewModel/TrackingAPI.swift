//
//  TrackingAPI.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/21/21.
//

import Foundation

class TrackingAPI: ObservableObject {
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
    }
    
    func getTrackingDetails(trackingNo: String, completion: @escaping ([TrackingHistoryDtls]) -> ()) {
        let userToken = userAccount[0].token
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/getTrackingDetails") else { return }
        
        let body: [String: String] = ["trackingNo": trackingNo]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(Tracking.self, from: data)
            
            if finalData?.message == "Tracking details have been successfully retrieved" {
                DispatchQueue.main.async {
                    completion(finalData!.result.trackingHistoryDetails)
                }
            } else {
                print("Cannot retrieve tracking details")
            }
        }.resume()
    }
}
