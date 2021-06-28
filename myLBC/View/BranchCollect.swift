//
//  BranchCollect.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct BranchCollect: View {
    @StateObject var balance = balanceAPI()
    @StateObject var serviceFeeAPI = ServiceFeeAPI()
    @StateObject var cashoutAPI = CashoutAPI()
    
    @State var amt: String = ""
    @State var serviceFee: String = "0.0"
    @State var selectedRelationship = ""
    @State var selectedPurpose = ""
    @State private var showSuccessAlert = false
    
    var relationships = ["None", "Donor / Receiver of Charitable Funds", "Employee / Employer", "Family", "Friends", "Personal/Own Account", "Purchase / Seller", "Trade / Business Partner"]
    
    var purposes = ["None", "Charity / Aid Payment", "Education / School Fees", "Emergency Medical Aid", "Employee Payroll/Expense", "Family Support/ Living Expenses", "Gift", "Goods & Srvcs Payment/ Commercial Trxn", "Prize or Lottery Fees/ Taxes", "Rent/ Mortgage", "Savings/ Investments", "Travel Expenses"]
    
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
                
                Form {
                
                    VStack(spacing: 6) {
                        
                        HStack(alignment: .bottom) {
                            
                            Image(systemName: "pesosign.circle")
                                .font(.system(size: 22))
                                .foregroundColor(.primary)
                                .frame(width: 35)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                if self.amt != "" {
                                    
                                    Text("Amount")
                                        .font(.caption)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.gray)
                                        .matchedGeometryEffect(id: "Amount", in: animation)
                                    
                                }
                                
                                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                    
                                    if self.amt == "" {
                                        
                                        Text("Amount")
                                            .font(.caption)
                                            .fontWeight(.heavy)
                                            .foregroundColor(.gray)
                                            .matchedGeometryEffect(id: "Amount", in: animation)
                                        
                                    }
                                    
                                    TextField(self.amt, text: Binding<String>(
                                        get: { self.amt },
                                        set: {
                                            self.amt = $0
                                            serviceFeeAPI.getServiceFee(amt: $0)
                                            self.serviceFee = serviceFeeAPI.serviceFee
                                        }
                                    ))
                                    .keyboardType(.decimalPad)
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                        if self.amt == "" {
                            Divider()
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color("txt").opacity(self.amt != "" ? 1 : 0))
                    .background(Color.white)
                    .border(self.amt != "" ? Color("crimson") : Color.gray, width: 2)
                    .padding(.top)
                    .animation(.linear)
                    
                    VStack(spacing: 6) {
                        
                        HStack(alignment: .bottom) {
                            
                            Image(systemName: "pesosign.circle")
                                .font(.system(size: 22))
                                .foregroundColor(.primary)
                                .frame(width: 35)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                
                                if self.serviceFee != "" {
                                    
                                    Text("Service Fee")
                                        .font(.caption)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.gray)
                                        .matchedGeometryEffect(id: "Service Fee", in: animation)
                                    
                                }
                                
                                ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                    
                                    if self.serviceFee == "" {
                                        
                                        Text("Service Fee")
                                            .font(.caption)
                                            .fontWeight(.heavy)
                                            .foregroundColor(.gray)
                                            .matchedGeometryEffect(id: "Service Fee", in: animation)
                                        
                                    }
                                    
                                    TextField(self.serviceFee, text: self.$serviceFee).disabled(true)
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                        if self.serviceFee == "" {
                            Divider()
                        }
                        
                        
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color("txt").opacity(self.serviceFee != "" ? 1 : 0))
                    .background(Color.white)
                    .border(self.serviceFee != "" ? Color("crimson") : Color.gray, width: 2)
                    .padding(.top)
                    .animation(.linear)
                    
                    VStack(spacing: 6) {
                        Picker(selection: $selectedRelationship, label: Text("Relationship")) {
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
                    
                    VStack(spacing: 6) {
                        Picker(selection: $selectedPurpose, label: Text("Purpose of Transfer")) {
                            ForEach(0 ..< purposes.count) {
                                Text(self.purposes[$0]).tag(self.purposes[$0])
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .border(Color.gray, width: 2)
                        .padding(.top)
                        .animation(.linear)
                    }
                    
                }
                
                Spacer()
            
            }
        
            VStack {
                
                Button(action: {
                    cashoutAPI.cashout(
                        amount: self.amt,
                        fee: self.serviceFee,
                        rel: self.selectedRelationship,
                        relDesc: self.selectedRelationship,
                        purpose: self.selectedPurpose,
                        purposeDesc: self.selectedPurpose
                        )
                    // TODO: completion of async task to trap error
                    self.showSuccessAlert.toggle()
                    self.amt = ""
                    self.serviceFee = "0.0"
                    self.selectedRelationship = "None"
                    self.selectedPurpose = "None"
                    balance.getBalance()
                }) {
                    Text("CONFIRM CASH OUT")
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
                .alert(isPresented: $showSuccessAlert, content: {
                    Alert(title: Text("MyLBC"), message: Text("Transaction has been processed"), dismissButton: .default(Text("OK")))
                })
            
            }
        }
        .navigationTitle("Branch Collect")
        
        Spacer()
    }
}
