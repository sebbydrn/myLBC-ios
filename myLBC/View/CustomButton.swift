//
//  CustomButton.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/17/21.
//

import SwiftUI

struct CustomButton: View {
    var action: String
    var title: String
    
    var body: some View {
        
        Button(action: {
            action
        }) {
            Text(title)
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
