//
//  TransactionDetailSheet.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct TransactionDetailSheet: View {
    @Binding var showModal: Bool
    
    var body: some View {
        
        VStack {
            
            VStack {
                Image("LBCLogo")
                    .resizable()
                    .frame(width: 100, height: 100)
            }
            .padding(.bottom, 15)
            
            VStack {
                
                HStack {
                    
                    Text("TRXN REF")
                    
                    Spacer()
                    
                    Text("1234567890")
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("DATE")
                    
                    Spacer()
                    
                    Text("Mar 25, 2021 11:55:15 AM")
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("BRANCH")
                    
                    Spacer()
                    
                    Text("")
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("GROSS AMOUNT")
                    
                    Spacer()
                    
                    Text("2.00")
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("FREIGHT FEE")
                    
                    Spacer()
                    
                    Text("")
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("COD FEE")
                    
                    Spacer()
                    
                    Text("")
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("RTS")
                    
                    Spacer()
                    
                    Text("")
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("OTHER FEES")
                    
                    Spacer()
                    
                    Text("")
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("NET AMOUNT")
                    
                    Spacer()
                    
                    Text("12.00")
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 15)
                
            }
            
            VStack {
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
            
//            Spacer()
            
        }
        .padding()
        
    }
}
