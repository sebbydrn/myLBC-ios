//
//  RegisterForm3.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/19/21.
//

import SwiftUI

struct RegisterForm3: View {
    @Binding var fname: String
    @Binding var mname: String
    @Binding var lname: String
    @Binding var maidenName: String
    @Binding var suffix: String
    @Binding var gender: Int
    @Binding var civilStatus: Int
    @Binding var nationality: String
    @Binding var bdate: Date
    @Binding var unitNo: String
    @Binding var bldg: String
    @Binding var add1: String
    @Binding var add2: String
    @Binding var province: Int
    @Binding var city: Int
    @Binding var zip: String
    @Binding var mobile: String
    @Binding var landline: String
    @Binding var email: String
    @State var idNo = ""
    @State var occupation = ""
    @State var companyName = ""
    @State var tinNo = ""
    @State var debitCardNo = ""
    
    @State var selectedIdType = IdTypes(type_id: 0, type_name: "", type_desc: "")
    
    var db: DBHelper = DBHelper()
    
    @State var idTypes: [IdTypes] = []
    
    @State var idExpiry = Date()
    
    @State private var showSuccessAlert = false
    
    func dateFromString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
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
            Picker(selection: $selectedIdType, label: Text("ID Type")) {
                ForEach(self.idTypes, id: \.self) { item in
                    Text(item.type_name)
                }
            }
            .onAppear {
                self.idTypes = db.getIdTypes()
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
        .navigationBarTitle("Sign Up", displayMode: .large)
        
        VStack(alignment: .center) {
            Button(action: {
                SignupAPI().signup(
                    email: self.email,
                    extId: "",
                    debitCardNumber: self.debitCardNo,
                    fname: self.fname,
                    mname: self.mname,
                    lname: self.lname,
                    suffix: self.suffix,
                    maidenName: self.maidenName,
                    bdate: dateFromString(date: self.bdate),
                    gender: self.gender,
                    civilStatus: self.civilStatus,
                    nationality: self.nationality,
                    unitNo: self.unitNo,
                    bldg: self.bldg,
                    add1: self.add1,
                    add2: self.add2,
                    province: self.province,
                    city: self.city,
                    zip: Int(self.zip)!,
                    mobile: self.mobile,
                    landline: self.landline,
                    occupation: self.occupation,
                    company: self.companyName,
                    tin: self.tinNo,
                    idNumber: self.idNo,
                    idType: self.selectedIdType.type_id,
                    idExpiry: dateFromString(date: self.idExpiry),
                    idPic: "",
                    custPic: "",
                    completion: { res in
                        if res == "Success" {
                            self.showSuccessAlert.toggle()
                        }
                    })
            }) {
                Text("SUBMIT")
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
                Alert(
                    title: Text("MyLBC"),
                    message: Text("Your account has been successfully created"),
                    dismissButton: .default(Text("OK")) {
                        // TODO: Navigate to login
                        print("back to login")
                    }
                )
            })
        }
    }
}
