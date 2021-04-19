//
//  ForgotPasswordSheet.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/17/21.
//

import SwiftUI

struct ForgotPasswordSheet: View {
    @Binding var showModal: Bool
    @State var email = ""
    @Namespace var animation
    
    var body: some View {
        
        VStack {
            
            Text("Password reset instruction will be sent to your email address")
                .italic()
                .foregroundColor(Color.gray)
            
            VStack {
                CustomTextField(image: "envelope", title: "Email address", showPassword: false, value: $email, animation: animation)
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
                
                CustomButton(action: "", title: "SUBMIT")
                
            }
            .padding(.top, 10)
            .padding(.horizontal)
            
        }
        
    }
}
