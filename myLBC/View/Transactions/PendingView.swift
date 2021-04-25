//
//  PendingView.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct Pending: Identifiable {
    let id = UUID()
    let date: String
    let action: String
    let transactionID: String
    let amount1: String
    let amount2: String
}

struct PendingRow: View {
    var pending: Pending
    
    @State private var toggleTransactionDetail = false
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(pending.date)
                
                Text(pending.transactionID)
                
                Button(action: {
                    self.toggleTransactionDetail.toggle()
                }) {
                    Text(pending.transactionID)
                        .foregroundColor(Color.blue)
                }
                .sheet(isPresented: $toggleTransactionDetail) {
                    TransactionDetailSheet(showModal: self.$toggleTransactionDetail)
                }
                
            }
            .font(.system(size: 16))
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
                Text(pending.action)
                
                Text(pending.amount1)
                
                Text(pending.amount2)
                
            }
            .font(.system(size: 16))
            
        }
        
        .padding(.bottom, 10)
        
    }
}

struct PendingView: View {
    var body: some View {
        
        let pendingData = [
            Pending(date: "Mar 25, 2021 11:55:15 AM", action: "Remit to Account", transactionID: "1234567890", amount1: "2.00", amount2: "7,739.00"),
            Pending(date: "Mar 25, 2021 11:54:34 AM", action: "Cash-out", transactionID: "Q6LWEQLW", amount1: "1.00", amount2: "7,741.00")
        ]
            
        List(pendingData) { pending in
            
            PendingRow(pending: pending)
            
        }
        
    }
}

