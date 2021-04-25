//
//  Login.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/17/21.
//

import SwiftUI

struct Login: View {
    @State var username = ""
    @State var password = ""
    @State var isLinkActive = false
    
    @Namespace var animation
    
    var body: some View {
        
        VStack {
            
            Image("LBCLogo")
                .padding()
            
            CustomTextField(image: "person", title: "Username", showPassword: false, value: $username, animation: animation)
            
            CustomTextField(image: "lock", title: "Password", showPassword: false, value: $password, animation: animation)
                .padding(.top, 5)
            
            HStack {
                
                RememberMeField(rememberMe: false)
                
                Spacer()
                    
                ForgotPassword()
                
            }
            .padding(.top, 10)
            .padding(.horizontal)
            
            NavigationLink(destination: Home(), isActive: $isLinkActive) {
                Button(action: {
                    self.isLinkActive = true
                }) {
                    Text("LOGIN")
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
            .padding(.top, 20)
            
            
            HStack {
                Text("No account yet? Sign up")
                    .padding(.top, 10)
                    .padding(.trailing, 0)
                    .foregroundColor(Color.gray)
                
                NavigationLink(destination: RegisterForm()) {
                    Text("here !")
                }
                .padding(.top, 10)
                .padding(.leading, -3)
            }
            
        }
        .navigationBarHidden(true)
    }
}
