//
//  CashOut.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct CashOut: View {
    @State private var toggleComingSoon = false
    
    @StateObject var balance = balanceAPI()
    
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
                        Text(balance.availableBalance)
                    }

                    Spacer()

                    VStack {
                        Text("Current")
                        Text(balance.currentBalance)
                    }

                }
                .onAppear{
                    balance.getBalance()
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
                    
                Text("Select transaction type")
                    .font(.title3)
                
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            .padding(.top, 15)
            
            VStack {
                
                NavigationLink(destination: BranchCollect()) {
                 
                    HStack {
                        
                        Image("LBCLogo")
                            .resizable()
                            .frame(width: 60, height: 50)
                        
                        Text("Branch Collect")
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
                        
                        Text("Door to Door")
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
        .navigationTitle("Cash Out")
        
        Spacer()
        
    }
}
