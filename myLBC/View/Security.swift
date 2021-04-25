//
//  Settings.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/25/21.
//

import SwiftUI

struct Security: View {
    @State private var toggleEnterPin = false
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    
                    Text("myBalance")
                        .font(.title2)
                    
                }
                
                HStack {
                    
                    VStack {
                        Text("Available")
                        Text("php 7,739.00")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Current")
                        Text("php 13,746.04")
                    }
                    
                }
                .padding()
                .padding(.top, -10)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.trailing, 10)
            .padding(.leading, 10)
            .padding(.top, 10)
            .padding(.bottom, 0)
            .background(Color("crimson"))
            .foregroundColor(Color.white)
            
            VStack {
                
                Button(action: {
                    self.toggleEnterPin.toggle()
                }) {
                    HStack {
                        
                        Image(systemName: "lock")
                            .imageScale(.large)
                            
                        Text("Change PIN")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                        
                    }
                    .foregroundColor(Color.gray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .sheet(isPresented: $toggleEnterPin) {
                    EnterPin(showModal: self.$toggleEnterPin)
                }
                .padding(.top, 15)
                
            }
            .padding()
            
            VStack {
                
                HStack {
                    
                    NavigationLink(destination: ChangePassword()) {
                        Image(systemName: "key")
                            .imageScale(.large)
                        
                        Text("Change Password")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                    }
                    
                }
                .foregroundColor(Color.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding()
            
            Spacer()
            
        }
        .navigationTitle("SECURITY")
        
    }
}
