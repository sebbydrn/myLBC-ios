//
//  TrackTrace.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/25/21.
//

import SwiftUI

struct TrackTrace: View {
    @State var trackingNumber = ""
    @State var trackingDtls: [TrackingHistoryDtls] = []
    
    @Namespace var animation
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                HStack(alignment: .center) {
                    
                    CustomTextField(image: "number", title: "Tracking Number", showPassword: false, value: $trackingNumber, animation: animation)
                    
                    VStack {
                        
                        Button(action: {
                            TrackingAPI().getTrackingDetails(trackingNo: trackingNumber, completion: { (trackingDtls) in
                                self.trackingDtls = trackingDtls
                            })
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
                
                List(trackingDtls) { dtls in
                    VStack(alignment: .leading) {
                        Button(action: {
                            
                        }) {
                            Text("\(dtls.TrackingHistoryID)")
                                .foregroundColor(Color.blue)
                        }
                        Spacer()
                        Text("\(dtls.DatePosted) \(dtls.DatePostedTime)")
                        Spacer()
                        Text("STATUS: \(dtls.StatusandLocation)")
                    }
                }
                
            }
            
        }
        .navigationTitle("Cargo Tracking")
        
        Spacer()
        
    }
}
