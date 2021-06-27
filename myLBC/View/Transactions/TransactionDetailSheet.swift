//
//  TransactionDetailSheet.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct TransactionDetailSheet: View {
    @Binding var showModal: Bool
    @Binding var trxnRef: String
    @Binding var trxDate: String
    @Binding var trxBranch: String
    @Binding var trxGrossAmt: String
    @Binding var trxFreightFee: String
    @Binding var trxCodFee: String
    @Binding var trxRts: String
    @Binding var trxOtherFee: String
    @Binding var trxNetAmt: String
    
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
                    
                    Text(trxnRef)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("DATE")
                    
                    Spacer()
                    
                    Text(trxDate)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("BRANCH")
                    
                    Spacer()
                    
                    Text(trxBranch)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("GROSS AMOUNT")
                    
                    Spacer()
                    
                    Text(trxGrossAmt)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("FREIGHT FEE")
                    
                    Spacer()
                    
                    Text(trxFreightFee)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("COD FEE")
                    
                    Spacer()
                    
                    Text(trxCodFee)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("RTS")
                    
                    Spacer()
                    
                    Text(trxRts)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("OTHER FEES")
                    
                    Spacer()
                    
                    Text(trxOtherFee)
                    
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.bottom, 5)
                
                HStack {
                    
                    Text("NET AMOUNT")
                    
                    Spacer()
                    
                    Text(trxNetAmt)
                    
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
            
        }
        .padding()
        
    }
}
