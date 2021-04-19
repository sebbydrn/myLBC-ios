//
//  RegisterForm3.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/19/21.
//

import SwiftUI

struct RegisterForm3: View {
    @State var idNo = ""
    @State var occupation = ""
    @State var companyName = ""
    @State var tinNo = ""
    @State var debitCardNo = ""
    
    @State private var idTypeIndex = 0
    
    var idTypes = ["Alien Certification of Registration", "Driver's License", "Employment ID (Government and Private)", "Firearm license", "Government Service and Insurance (GSIS) e-card"]
    
    @State private var idExpiry = Date()
    
    @Namespace var animation
    
    var body: some View {
        
        HStack {
            Text("Primary Details >")
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
            Text("Address & Contact >")
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
            Text("Identification")
                .foregroundColor(Color.blue)
                .font(.system(size: 14))
        }
            
        Form {
                
            CustomTextFieldReg(image: "person", title: "ID Number", showPassword: false, value: $idNo, animation: animation)
            
            // ID Type field here
            Picker(selection: $idTypeIndex, label: Text("ID Type")) {
                ForEach(0 ..< idTypes.count) {
                    Text(self.idTypes[$0]).tag($0)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            
            // ID Expiry
            DatePicker("ID Expiry", selection: $idExpiry, displayedComponents: .date)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.white)
                .border(Color.gray, width: 2)
                .padding(.top)
                .animation(.linear)
            
            CustomTextFieldReg(image: "briefcase", title: "Occupation", showPassword: false, value: $occupation, animation: animation)
            
            CustomTextFieldReg(image: "briefcase", title: "Company Name", showPassword: false, value: $companyName, animation: animation)
            
            CustomTextFieldReg(image: "number", title: "TIN Number", showPassword: false, value: $tinNo, animation: animation)
            
            CustomTextFieldReg(image: "creditcard", title: "Debit Card Number", showPassword: false, value: $debitCardNo, animation: animation)
                .padding(.bottom, 10)
            
        }
        .navigationTitle(Text("Sign Up"))
        
        VStack(alignment: .center) {
            CustomButton(action: "", title: "SUBMIT")
                .padding(.top, 10)
        }
    }
}
