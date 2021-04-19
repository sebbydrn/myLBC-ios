//
//  RegisterForm.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/18/21.
//

import SwiftUI

struct RegisterForm: View {
    @State var firstName = ""
    @State var middleName = ""
    @State var lastName = ""
    @State var mothersMaidenName = ""
    
    @State private var suffixIndex = 0
    @State private var sexIndex = 0
    @State private var civilStatusIndex = 0
    @State private var nationalityIndex = 0
    
    var suffixes = ["None", "III", "IV", "JR", "SR", "V", "VI", "ma"]
    var sex = ["Female", "Male"]
    var civilStatus = ["Married", "Separated", "Single", "Widowed"]
    var nationality = ["Filipino"]
    
    @State private var birthDate = Date()
    
    @Namespace var animation
    
    var body: some View {
        
        HStack {
            Text("Primary Details >")
                .foregroundColor(Color.blue)
                .font(.system(size: 14))
            Text("Address & Contact >")
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
            Text("Identification")
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
        }
            
        Form {
                
            CustomTextFieldReg(image: "person", title: "First Name", showPassword: false, value: $firstName, animation: animation)
        
            CustomTextFieldReg(image: "person", title: "Middle Name", showPassword: false, value: $middleName, animation: animation)
            
            CustomTextFieldReg(image: "person", title: "Last Name", showPassword: false, value: $lastName, animation: animation)
            
            
            // Suffix field here
            Picker(selection: $suffixIndex, label: Text("Suffix")) {
                ForEach(0 ..< suffixes.count) {
                    Text(self.suffixes[$0]).tag($0)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            
            CustomTextFieldReg(image: "person", title: "Mother's Maiden Name", showPassword: false, value: $mothersMaidenName, animation: animation)
            
            // Date of Birth
            DatePicker("Date of Birth", selection: $birthDate, displayedComponents: .date)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color.white)
                .border(Color.gray, width: 2)
                .padding(.top)
                .animation(.linear)
            
            // Sex field here
            Picker(selection: $sexIndex, label: Text("Sex")) {
                ForEach(0 ..< sex.count) {
                    Text(self.sex[$0]).tag($0)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            
            // Civil status field here
            Picker(selection: $civilStatusIndex, label: Text("Civil Status")) {
                ForEach(0 ..< civilStatus.count) {
                    Text(self.civilStatus[$0]).tag($0)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            
            // Nationality field here
            Picker(selection: $nationalityIndex, label: Text("Nationality")) {
                ForEach(0 ..< nationality.count) {
                    Text(self.nationality[$0]).tag($0)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            .padding(.bottom, 10)
            
        }
        .navigationTitle(Text("Sign Up"))
        
        VStack(alignment: .center) {
            NavigationLink(destination: RegisterForm2()) {
                
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
