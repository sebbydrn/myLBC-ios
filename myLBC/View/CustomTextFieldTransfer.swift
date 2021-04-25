//
//  CustomTextFieldTransfer.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/25/21.
//

import SwiftUI

struct CustomTextFieldTransfer: View {
    
    // Fields...
    var image: String
    var title: String
    @State var showPassword: Bool
    @Binding var value: String
    
    var animation: Namespace.ID
    
    var body: some View {
        
        VStack(spacing: 6) {
            
            HStack(alignment: .bottom) {
                
                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundColor(.primary)
                    .frame(width: 35)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    if value != "" {
                        
                        Text(title)
                            .font(.caption)
                            .fontWeight(.heavy)
                            .foregroundColor(.gray)
                            .matchedGeometryEffect(id: title, in: animation)
                        
                    }
                    
                    ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                        
                        if value == "" {
                            
                            Text(title)
                                .font(.caption)
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                                .matchedGeometryEffect(id: title, in: animation)
                            
                        }
                        
                        if title == "Password" {
                            
                            HStack {
                                
                                if showPassword == false {
                                    
                                    SecureField("", text: $value)
                                    
                                }
                                else {
                                    
                                    TextField("", text: $value)
                                    
                                }
                                
                                Button(action: {
                                    self.showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword != false ? "eye.fill" : "eye.slash.fill")
                                        .foregroundColor(Color.gray)
                                }
                                
                            }
                            
                        }
                        else if title == "Amount" {
                            
                            TextField("", text: $value)
                                .keyboardType(.decimalPad)
                            
                        }
                        else if title == "Service Fee" {
                            
                            TextField("", text: $value)
                                .disabled(true)
                            
                        }
                        else {
                            
                            TextField("", text: $value)
                            
                        }
                        
                        
                    }
                    
                }
                
            }
            
            if value == "" {
                
                Divider()
            }
            
            
        }
        .padding(.vertical, 10)
        .background(Color("txt").opacity(value != "" ? 1 : 0))
        .background(Color.white)
        .border(value != "" ? Color("crimson") : Color.gray, width: 2)
        .padding(.top)
        .animation(.linear)
    }
}
