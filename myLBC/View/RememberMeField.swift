//
//  RememberMeField.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/17/21.
//

import SwiftUI

struct RememberMeField: View {
    @State var rememberMe: Bool
    
    var body: some View {
        
        HStack {
            
            Button(action: {
                self.rememberMe.toggle()
            }) {
                Image(systemName: rememberMe == false ? "square" : "checkmark.square")
                    .foregroundColor(Color("crimson"))
                    .font(.system(size: 25))
            }
            
            Text("Remember me")
        }
        
    }
}
