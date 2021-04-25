//
//  SavedAccounts.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct Account: Identifiable {
    let id = UUID()
    let bank: String
    let name: String
    let type: String
    let number: String
}

struct AccountRow: View {
    var account: Account
    
    var body: some View {
        
        VStack {
            
            HStack {
                
                Text("Bank")
                
                Spacer()
                
                Text(account.bank)
                
            }
            
            HStack {
                
                Text("Account Name")
                
                Spacer()
                
                Text(account.name)
                
            }
            
            HStack {
                
                Text("Account Type")
                
                Spacer()
                
                Text(account.type)
                
            }
            
            HStack {
                
                Text("Account No.")
                
                Spacer()
                
                Text(account.number)
                
            }
            
            HStack {
                
                Text("Remove Account")
                    .foregroundColor(Color.red)
                
                Spacer()
                
                Text("Use Account")
                    .foregroundColor(Color.blue)
                
            }
            .padding(.top, 15)
            
        }
        .padding(.top, 10)
        .padding(.bottom, 15)
        .foregroundColor(Color.gray)
        
    }
    
}

struct SavedAccounts: View {
    var body: some View {
        
        let accountsData = [
            Account(bank: "AMWSLAI Bank", name: "13 123", type: "Savings", number: "1231"),
            Account(bank: "Asia United Bank", name: "jhar 4sd", type: "Savings", number: "1234123")
        ]
        
        VStack {
            
            List(accountsData) { account in
                
                AccountRow(account: account)
                
            }
            
        }
        .navigationTitle("My Saved Accounts")
        
    }
}
