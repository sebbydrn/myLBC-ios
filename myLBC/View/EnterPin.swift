//
//  EnterPin.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/25/21.
//

import SwiftUI

struct EnterPin: View {
    @Binding var showModal: Bool
    @State var pin = ""
    @Namespace var animation
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Current Pin")
                .bold()
                .foregroundColor(Color.gray)
                .font(.system(size: 20))
                .padding(.leading, 15)
            
            VStack {
                CustomTextField(image: "lock", title: "PIN", showPassword: false, value: $pin, animation: animation)
            }
            
            HStack {
                
                Spacer()
                
                Button(action: {
                    self.showModal.toggle()
                    
                }) {
                    Text("CANCEL")
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
                
                CustomButton(action: "", title: "VERIFY")
                
            }
            .padding(.top, 10)
            .padding(.horizontal)
            
        }
        
    }
}
