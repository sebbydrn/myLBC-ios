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
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                HStack(alignment: .center) {
                    
                    CustomTextField(image: "number", title: "Tracking Number", showPassword: false, value: $trackingNumber, animation: animation)
                    
                    VStack {
                        
                        CustomButton(action: "", title: "TRACK")
                        
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
