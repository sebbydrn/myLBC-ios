//
//  BankAccount2.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/25/21.
//

import SwiftUI

struct BankAccount2: View {
    @Binding var rtaBankCode: String
    @Binding var rtaBankBranch: String
    @Binding var rtaRcvrAcctNo: String
    @Binding var rtaRel: String
    @State var firstName = ""
    @State var lastName = ""
//    @State var streetAddress = ""
    @State var contact = ""
    @State var saveAccount: Bool
    @State var amount = ""
    @State var serviceFee = "0.0"
    
    @StateObject var serviceFeeAPI = ServiceFeeAPI()
    
    @Namespace var animation
    
    @State var selectedPurpose = 0
    
    var purposes = ["None", "Charity / Aid Payment", "Education / School Fees", "Emergency Medical Aid"]
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                VStack(alignment: .leading) {
                    
                    VStack {
                        Text("REMINDER ON ACCOUNT HOLDER INFORMATION")
                            .bold()
                            .font(.system(size: 14))
                    }
                    
                    HStack(alignment: .top) {
                        
                        VStack {
                            Text("For Company or Business Accounts, please encode the account name using the following example:")
                                .font(.system(size: 14))
                        }
                        
                    }
                    
                    HStack(alignment: .top) {
                        
                        VStack {
                            Text("Account Holder Firstname: ABC")
                                .font(.system(size: 14))
                        }
                        
                    }
                    
                    HStack(alignment: .top) {
                        
                        VStack {
                            Text("Account Holder Lastname: COMPANY, Inc.")
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
            
            Form {
                
                CustomTextFieldTransfer(image: "person", title: "Account Holder Firstname", showPassword: false, value: $firstName, animation: animation)

                CustomTextFieldTransfer(image: "person", title: "Account Holder Lastname", showPassword: false, value: $lastName, animation: animation)

//                CustomTextFieldTransfer(image: "mappin", title: "Street Address", showPassword: false, value: $streetAddress, animation: animation)

                CustomTextFieldTransfer(image: "iphone", title: "Contact Number", showPassword: false, value: $contact, animation: animation)

                HStack {

                    Button(action: {
                        self.saveAccount.toggle()
                    }) {
                        Image(systemName: saveAccount == false ? "square" : "checkmark.square")
                            .foregroundColor(Color("crimson"))
                            .font(.system(size: 25))
                    }

                    Text("Save account details")
                }

                VStack(spacing: 6) {
                    
                    HStack(alignment: .bottom) {
                        
                        Image(systemName: "pesosign.circle")
                            .font(.system(size: 22))
                            .foregroundColor(.primary)
                            .frame(width: 35)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            if self.amount != "" {
                                
                                Text("Amount")
                                    .font(.caption)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.gray)
                                    .matchedGeometryEffect(id: "Amount", in: animation)
                                
                            }
                            
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                
                                if self.amount == "" {
                                    
                                    Text("Amount")
                                        .font(.caption)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.gray)
                                        .matchedGeometryEffect(id: "Amount", in: animation)
                                    
                                }
                                
                                TextField(self.amount, text: Binding<String>(
                                    get: { self.amount },
                                    set: {
                                        self.amount = $0
                                        serviceFeeAPI.getServiceFee(amt: $0)
                                        self.serviceFee = serviceFeeAPI.serviceFee
                                    }
                                ))
                                .keyboardType(.decimalPad)
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    if self.amount == "" {
                        Divider()
                    }
                    
                    
                }
                .padding(.vertical, 10)
                .background(Color("txt").opacity(self.amount != "" ? 1 : 0))
                .background(Color.white)
                .border(self.amount != "" ? Color("crimson") : Color.gray, width: 2)
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
                .padding(.vertical, 10)
                .background(Color("txt").opacity(self.serviceFee != "" ? 1 : 0))
                .background(Color.white)
                .border(self.serviceFee != "" ? Color("crimson") : Color.gray, width: 2)
                .padding(.top)
                .animation(.linear)
                
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
            .padding(.leading, -15)
            .padding(.trailing, -15)
            
            Spacer()
            
        }
        .padding(.top, 15)
        
        VStack(alignment: .center) {
            CustomButton(action: "", title: "CONFIRM")
                .padding(.top, 10)
        }
        
    }
}
