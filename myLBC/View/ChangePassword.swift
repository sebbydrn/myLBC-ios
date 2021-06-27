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
    @State private var toggleSuccessAlert = false
    @State private var togglePasswordErr = false
    
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
                
                Button(action: {
                    if self.currentPassword != "" && self.newPassword != "" {
                        if self.newPassword == self.newPassword2 {
                            ChangePassAPI().changePass(
                                currPasswd: self.currentPassword,
                                newPasswd: self.newPassword,
                                completion: { res in
                                    if res == "Success" {
                                        self.toggleSuccessAlert.toggle()
                                    }
                                }
                            )
                        } else {
                            self.togglePasswordErr.toggle()
                        }
                    }
                }) {
                    Text("SAVE")
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
                .alert(isPresented: $togglePasswordErr, content: {
                    Alert(
                        title: Text("MyLBC"),
                        message: Text("Password do not match"),
                        dismissButton: .default(Text("OK"))
                    )
                })
                .alert(isPresented: $toggleSuccessAlert, content: {
                    Alert(
                        title: Text("MyLBC"),
                        message: Text("Password has been changed!"),
                        dismissButton: .default(Text("OK")) {
                            self.currentPassword = ""
                            self.newPassword = ""
                            self.newPassword2 = ""
                        }
                    )
                })
                
            }
            
        }
        .navigationTitle("Change Password")
        
    }
}
