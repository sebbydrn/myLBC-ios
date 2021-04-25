//
//  BranchCollect.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct BranchCollect: View {
    @State var amount = ""
    @State var serviceFee = "0.0"
    
    @Namespace var animation
    
    var body: some View {
        
        VStack {
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
                    
                    Text("Branch Collect")
                        .font(.title3)
                        .foregroundColor(Color.gray)
                    
                }
                .padding(.top, 15)
                .padding(.bottom, 5)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                
                VStack {
                    
                    Text("Claim your cash out at any LBC branch!")
                        .foregroundColor(Color.gray)
                    
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                
                VStack {
                  
                    Text("A reference number shall be generated for the cash out.")
                        .foregroundColor(Color.gray)
                        .italic()
                        .font(.system(size: 14))
                    
                }
                .padding(.leading, 15)
                .padding(.trailing, 15)
                
                CustomTextField(image: "pesosign.circle", title: "Amount", showPassword: false, value: $amount, animation: animation)
                
                CustomTextField(image: "pesosign.circle", title: "Service Fee", showPassword: false, value: $serviceFee, animation: animation)
                
                Spacer()
            
            }
        
            VStack {
            
                CustomButton(action: "", title: "CONFIRM CASH OUT")
            
            }
        }
        .navigationTitle("Branch Collect")
        
        Spacer()
    }
}
