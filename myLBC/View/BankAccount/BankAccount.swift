//
//  BankAccount.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct BankAccount: View {
    var db: DBHelper = DBHelper()
    
    @State var banks: [RtaBanks] = []
    @State var accountTypes: [RtaAcctTypes] = []
    @State var selectedBank = RtaBanks(bank_id: 0, code: "", name: "")
    @State var selectAcctType = RtaAcctTypes(rta_type_id: 0, name: "")
    @State var selectedRelationship = ""
//    @State var selectedRelationshipDesc = ""
    @State var bankBranch = ""
    @State var accountNumber = ""
    
    @Namespace var animation
    
    var relationships = ["None", "Donor / Receiver of Charitable Funds", "Employee / Employer", "Family", "Friends", "Personal/Own Account", "Purchase / Seller", "Trade / Business Partner"]
    
    var body: some View {
        
        VStack {
          
            VStack {
                
                VStack(alignment: .leading) {
                    
                    VStack {
                        Text("Crediting Schedule")
                            .bold()
                            .font(.system(size: 14))
                    }
                    
                    HStack(alignment: .top) {
                        
                        VStack {
                            Text("1. ")
                                .font(.system(size: 14))
                        }
                        
                        VStack {
                            Text("For transfer amounts PHP 50,000.00 and below, the amount will be credited to your bank account within 1 hour. Cut-off time is at 5:00 PM daily")
                                .font(.system(size: 14))
                        }
                        
                    }
                    
                    HStack(alignment: .top) {
                        
                        VStack {
                            Text("2. ")
                                .font(.system(size: 14))
                        }
                        
                        VStack {
                            Text("For transfer amounts PHP 50,000.01 and above, the amount will be credited to your bank account on the next banking day")
                                .font(.system(size: 14))
                        }
                        
                    }
                    
                }
                .padding()
                .background(Color("crimson"))
                .foregroundColor(Color.white)
                
            }
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
            VStack {
                
                HStack {
                    
                    Text("RESET FORM")
                        .font(.system(size: 14))
                        .foregroundColor(Color.blue)
                    
                    Spacer()
                    
                    NavigationLink(destination: SavedAccounts()) {
                        
                        Text("SELECT FROM SAVED ACCOUNTS")
                            .font(.system(size: 14))
                        
                    }
                    
                }
                
            }
            .padding(.top, 10)
            .padding(.leading, 15)
            .padding(.trailing, 15)
            
            Form {
                
                Picker(selection: $selectedBank, label: Text("Bank")) {
                    ForEach(self.banks, id: \.self) { item in
                        Text(item.name)
                    }
                }
                .onAppear {
                    self.banks = db.getRTABanks()
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.white)
                .border(Color.gray, width: 2)
                .padding(.top)
                .animation(.linear)
                
                CustomTextFieldTransfer(image: "building", title: "Bank Branch", showPassword: false, value: $bankBranch, animation: animation)
                
                Picker(selection: $selectAcctType, label: Text("Account Type")) {
                    ForEach(self.accountTypes, id: \.self) { item in
                        Text(item.name)
                    }
                }
                .onAppear {
                    self.accountTypes = db.getRTAAcctTypes()
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.white)
                .border(Color.gray, width: 2)
                .padding(.top)
                .animation(.linear)
                
                CustomTextFieldTransfer(image: "number", title: "Account Number", showPassword: false, value: $accountNumber, animation: animation)

                Picker(selection: $selectedRelationship, label: Text("Relationship to acct holder")) {
                    ForEach(0 ..< relationships.count) {
                        Text(self.relationships[$0]).tag(self.relationships[$0])
                    }
                }
//                .onChange(of: $selectedRelationship, perform: { value in
//                    self.selectedRelationshipDesc = self.relationships[value]
//                    print(self.selectedRelationshipDesc)
//                })
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.white)
                .border(Color.gray, width: 2)
                .padding(.top)
                .animation(.linear)
            }
            .padding(.leading, -15)
            .padding(.trailing, -15)
            
            Spacer()
            
        }
        .navigationTitle("Bank Account")
        .padding(.top, 15)
        
        VStack(alignment: .center) {
            NavigationLink(destination: BankAccount2(
                rtaBankCode: self.$selectedBank.code,
                rtaBankBranch: self.$bankBranch,
                rtaRcvrAcctNo: self.$accountNumber,
                rtaRel: self.$selectedRelationship,
                saveAccount: false
            )) {
                
                Text("NEXT")
                    .foregroundColor(Color.white)
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
            .padding(.top, 10)
        }
        
        
    }
}
