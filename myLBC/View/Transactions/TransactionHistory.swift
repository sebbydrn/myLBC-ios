//
//  TransactionHistory.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct TransactionHistory: View {
    var body: some View {
        
        VStack {
            TabView {
                PendingView()
                    .tabItem {
                        Label("PENDING", systemImage: "list.dash")
                    }
                
                CompletedView()
                    .tabItem {
                        Label("COMPLETED", systemImage: "checkmark.circle")
                    }
            }
        }
        .navigationTitle("My Transactions")
        
    }
}
