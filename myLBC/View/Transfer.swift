//
//  Transfer.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct Transfer: View {
    @State private var toggleComingSoon = false
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
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
                    
                Text("Select transfer fund type")
                    .font(.title3)
                
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .padding(.top, 15)
            
            VStack {
                
                NavigationLink(destination: BankAccount()) {
                 
                    HStack {
                        
                        Image("LBCLogo")
                            .resizable()
                            .frame(width: 60, height: 50)
                        
                        Text("To bank account")
                            .foregroundColor(Color.black)
                        
                    }
                    
                }
                
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
            VStack {
                
                Button(action: {
                    self.toggleComingSoon.toggle()
                }) {
                    HStack {
                        
                        Image("LBCLogo")
                            .resizable()
                            .frame(width: 60, height: 50)
                        
                        Text("To another LBC wallet")
                            .foregroundColor(Color.black)
                        
                    }
                }
                .sheet(isPresented: $toggleComingSoon) {
                    ComingSoonSheet(showModal: self.$toggleComingSoon)
                }
                
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
            VStack {
                
                Button(action: {
                    self.toggleComingSoon.toggle()
                }) {
                    HStack {
                        
                        Image("LBCLogo")
                            .resizable()
                            .frame(width: 60, height: 50)
                        
                        Text("To card")
                            .foregroundColor(Color.black)
                        
                    }
                }
                .sheet(isPresented: $toggleComingSoon) {
                    ComingSoonSheet(showModal: self.$toggleComingSoon)
                }
                
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
        }
        .navigationTitle("Transfer")
        
        Spacer()
        
    }
}
