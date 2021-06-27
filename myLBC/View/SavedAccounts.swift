//
//  SavedAccounts.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct SavedAccounts: View {
    @State var rtaAccts: [RTAAcctsList] = []
    
    var body: some View {
        
        VStack {
            List(rtaAccts) { acct in
                VStack {
                    
                    HStack {
                        
                        Text("Bank")
                        
                        Spacer()
                        
                        Text("\(acct.bankName)")
                        
                    }
                    
                    HStack {
                        
                        Text("Account Name")
                        
                        Spacer()
                        
                        Text("\(acct.consignee_fname) \(acct.consignee_lname)")
                        
                    }
                    
                    HStack {
                        
                        Text("Account Type")
                        
                        Spacer()
                        
                        Text("\(acct.acctType)")
                        
                    }
                    
                    HStack {
                        
                        Text("Account No.")
                        
                        Spacer()
                        
                        Text("\(acct.consignee_acct_no)")
                        
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
            .onAppear {
                RTAAccountsAPI().getRTAAccts { (rtaAccts) in
                    self.rtaAccts = rtaAccts
                }
            }
        }
        .navigationTitle("My Saved Accounts")
        
    }
}
