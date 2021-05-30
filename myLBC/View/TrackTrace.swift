//
//  TrackTrace.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/25/21.
//

import SwiftUI

struct TrackTrace: View {
    @State var trackingNumber = ""
    
    @Namespace var animation
    
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
    }
    
    func getTrackingDetails() {
        let userToken = userAccount[0].token
        
        print(userToken)
        
        guard let url = URL(string: "http://ec2-54-251-121-234.ap-southeast-1.compute.amazonaws.com:3000/lbcapi/ss/getTrackingDetails") else { return }
        
        let body: [String: String] = ["trackingNo": self.trackingNumber]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(TrackingMessage.self, from: data)
            
            print(finalData)
            
            if finalData?.message == "Tracking details have been successfully retrieved" {
                DispatchQueue.main.async {
                    
                }
            } else {
                print("Cannot retrieve tracking details")
            }
        }.resume()
    }
    
    struct TrackingMessage: Codable {
        let id: String
        let message: String
        let result: TrackingResult
    }

    struct TrackingResult: Codable {
        let responseCode: Int
        var trackingHistoryDetails: [TrackingHistoryDetails] = []
    }
    
    struct TrackingHistoryDetails: Codable {
        let StatusId: String
        let DatePosted: String
        let StatusandLocation: String
        let DatePostedTime: String
        let Remarks: String
        let TrackingHistoryID: String
        let DateInserted: String
    }
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                HStack(alignment: .center) {
                    
                    CustomTextField(image: "number", title: "Tracking Number", showPassword: false, value: $trackingNumber, animation: animation)
                    
                    VStack {
                        
                        Button(action: {
                            getTrackingDetails()
                        }) {
                            Text("TRACK")
                                .foregroundColor(Color.white)
                        }
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .background(Color("crimson"))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("crimson"), lineWidth: 2)
                        )
                        
                    }
                    .padding(.top, 15)
                    
                }
                
            }
            .padding(.top, 10)
            .padding(.trailing, 10)
            .padding(.bottom, 15)
            
            VStack {
                
                Text("Tracking History")
                    .foregroundColor(Color.gray)
                    .bold()
                
            }
            
        }
        .navigationTitle("Track & Trace")
        
        Spacer()
        
    }
}
