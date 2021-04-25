//
//  ComingSoonSheet.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct ComingSoonSheet: View {
    @Binding var showModal: Bool
    
    var body: some View {
        
        VStack {
            
            Image("LBCLogo")
                .resizable()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            
            Text("This feature is coming soon!")
                .padding(.bottom, 10)
            
            Button(action: {
                self.showModal.toggle()
            }) {
                Text("DONE")
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
        
    }
}
