//
//  ChangePassword.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/25/21.
//

import SwiftUI

struct ChangePassword: View {
    @State var currentPassword = ""
    @State var newPassword = ""
    @State var newPassword2 = ""
    
    @Namespace var animation
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading) {
                
                VStack {
                    
                    CustomTextField(image: "lock", title: "Current Password", showPassword: false, value: $currentPassword, animation: animation)
                        .padding(.top, 5)
                    
                    CustomTextField(image: "lock", title: "New Password", showPassword: false, value: $newPassword, animation: animation)
                        .padding(.top, 15)
                    
                    CustomTextField(image: "lock", title: "Re-type New Password", showPassword: false, value: $newPassword2, animation: animation)
                        .padding(.top, 5)
                    
                }
                
                VStack(alignment: .leading) {
                    
                    Text("New password must contain at least")
                        .italic()
                        .font(.system(size: 14))
                    Text("1 uppercase,")
                        .italic()
                        .font(.system(size: 14))
                    Text("1 lowercase,")
                        .italic()
                        .font(.system(size: 14))
                    Text("1 numeric,")
                        .italic()
                        .font(.system(size: 14))
                    Text("1 special character (!@#$%^&*)")
                        .italic()
                        .font(.system(size: 14))
                    Text("and at least 8 characters in length")
                        .italic()
                        .font(.system(size: 14))
                    
                }
                .padding(.top, 15)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                .foregroundColor(Color.gray)
                
            }
            
            Spacer()
            
            VStack {
                
                CustomButton(action: "", title: "SAVE")
                
            }
            
        }
        .navigationTitle("Change Password")
        
    }
}
