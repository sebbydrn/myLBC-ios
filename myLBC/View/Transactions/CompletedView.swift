//
//  CompletedView.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct Completed: Identifiable {
    let id = UUID()
    let date: String
    let action: String
    let transactionID: String
    let amount1: String
    let amount2: String
}

struct CompletedRow: View {
    var completed: Completed
    
    @State private var toggleTransactionDetail = false
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(completed.date)
                
                Text(completed.transactionID)
                
                Button(action: {
                    self.toggleTransactionDetail.toggle()
                }) {
                    Text(completed.transactionID)
                        .foregroundColor(Color.blue)
                }
                .sheet(isPresented: $toggleTransactionDetail) {
                    TransactionDetailSheet(showModal: self.$toggleTransactionDetail)
                }
                
            }
            .font(.system(size: 16))
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
                Text(completed.action)
                
                Text(completed.amount1)
                
                Text(completed.amount2)
                
            }
            .font(.system(size: 16))
            
        }
        
        .padding(.bottom, 10)
        
    }
}

struct CompletedView: View {
    var body: some View {
        
        let completedData = [
            Completed(date: "Nov 29, 2020 5:44:32 PM", action: "Cash-in", transactionID: "ABCDEFG1662", amount1: "1,000.00", amount2: "10,007.00"),
            Completed(date: "Nov 28, 2020 9:55:40 PM", action: "Cash-in", transactionID: "kr7SGhPI", amount1: "1,000.00", amount2: "10,007.00")
        ]
            
        List(completedData) { completed in
            
            CompletedRow(completed: completed)
            
        }
        
    }
}
