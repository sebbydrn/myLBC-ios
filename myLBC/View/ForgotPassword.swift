//
//  ForgotPassword.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/17/21.
//

import SwiftUI

struct ForgotPassword: View {
    @State private var toggleForgotPassForm = false
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                self.toggleForgotPassForm.toggle()
            }) {
                Text("Forgot password")
                    .italic()
                    .foregroundColor(Color.gray)
            }
            .sheet(isPresented: $toggleForgotPassForm) {
                ForgotPasswordSheet(showModal: self.$toggleForgotPassForm)
            }
            
        }
        
    }
}
