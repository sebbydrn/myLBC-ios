//
//  BankAccount2.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/25/21.
//

import SwiftUI

struct BankAccount2: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var streetAddress = ""
    @State var contact = ""
    @State var saveAccount: Bool
    @State var amount = ""
    @State var serviceFee = "0.0"
    
    @Namespace var animation
    
    @State private var purposeIndex = 0
    
    var purposes = ["None", "Charity / Aid Payment", "Education / School Fees", "Emergency Medical Aid"]
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                VStack(alignment: .leading) {
                    
                    VStack {
                        Text("Consignee Info")
                            .bold()
                            .font(.system(size: 14))
                    }
                    
                    HStack(alignment: .top) {
                        
                        VStack {
                            Text("For company accounts, please split the name:")
                                .font(.system(size: 14))
                        }
                        
                    }
                    
                    HStack(alignment: .top) {
                        
                        VStack {
                            Text("Example: ABC Company, Inc")
                                .font(.system(size: 14))
                        }
                        
                    }
                    
                    HStack(alignment: .top) {
                        
                        VStack {
                            Text("First Name: ABC Last Name: Company Inc")
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
                
                CustomTextFieldTransfer(image: "person", title: "First Name", showPassword: false, value: $firstName, animation: animation)

                CustomTextFieldTransfer(image: "person", title: "Last Name", showPassword: false, value: $lastName, animation: animation)

                CustomTextFieldTransfer(image: "mappin", title: "Street Address", showPassword: false, value: $streetAddress, animation: animation)

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

                CustomTextFieldTransfer(image: "pesosign.circle", title: "Amount", showPassword: false, value: $amount, animation: animation)

                CustomTextFieldTransfer(image: "pesosign.circle", title: "Service Fee", showPassword: false, value: $serviceFee, animation: animation)
                
                Picker(selection: $purposeIndex, label: Text("Purpose of Transfer")) {
                    ForEach(0 ..< purposes.count) {
                        Text(self.purposes[$0]).tag($0)
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
