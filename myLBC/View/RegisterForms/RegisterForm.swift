//
//  RegisterForm.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/18/21.
//

import SwiftUI

struct RegisterForm: View {
    @State var firstName: String = ""
    @State var middleName = ""
    @State var lastName = ""
    @State var mothersMaidenName = ""
    @State var selectedSuffix = Suffix(suffix_id: 0, suffix: "", description: "")
    @State var selectedGender = Gender(gender_id: 0, gender_name: "")
    @State var selectedCivilStatus = CivilStatus(status_id: 0, status_name: "")
    @State var selectedNationality = Nationality(nationality_name: "")
    
    var db: DBHelper = DBHelper()
    
    @State var suffixes: [Suffix] = []
    @State var genders: [Gender] = []
    @State var civilStatuses: [CivilStatus] = []
    @State var nationalities: [Nationality] = []
    
    @State var birthDate = Date()
    
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
            Picker(selection: $selectedSuffix, label: Text("Suffix")) {
                ForEach(self.suffixes, id: \.self) { item in
                    Text(item.suffix)
                }
            }
            .onAppear {
                self.suffixes = db.getSuffix()
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
            Picker(selection: $selectedGender, label: Text("Sex")) {
                ForEach(self.genders, id: \.self) { item in
                    Text(item.gender_name)
                }
            }
            .onAppear {
                self.genders = db.getGender()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            
            // Civil status field here
            Picker(selection: $selectedCivilStatus, label: Text("Civil Status")) {
                ForEach(self.civilStatuses, id: \.self) { item in
                    Text(item.status_name)
                }
            }
            .onAppear {
                self.civilStatuses = db.getCivilStatus()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            
            // Nationality field here
            Picker(selection: $selectedNationality, label: Text("Nationality")) {
                ForEach(self.nationalities, id: \.self) { item in
                    Text(item.nationality_name)
                }
            }
            .onAppear {
                self.nationalities = db.getNationality()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            .padding(.bottom, 10)
            
        }
        .navigationBarTitle("Sign Up", displayMode: .large)
        
        VStack(alignment: .center) {
            NavigationLink(destination: RegisterForm2(
                fname: self.$firstName,
                mname: self.$middleName,
                lname: self.$lastName,
                maidenName: self.$mothersMaidenName,
                suffix: self.$selectedSuffix.suffix,
                gender: self.$selectedGender.gender_id,
                civilStatus: self.$selectedCivilStatus.status_id,
                nationality: self.$selectedNationality.nationality_name,
                bdate: self.$birthDate
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
            
//            NavigationLink(destination: RegisterForm2(
//                    fname: self.$firstName,
//                    mname: self.$middleName,
//                    lname: self.$lastName,
//                    maidenName: self.$mothersMaidenName,
//                    suffix: String(self.$selectedSuffix.suffix_id),
//                    gender: String(self.$selectedGender.gender_id),
//                    civilStatus: String(self.$selectedCivilStatus.status_id),
//                    nationality: String(self.$selectedNationality.nationality_name),
//                    bdate: String(self.$birthDate)
//                )) {
//
//                    Text("NEXT")
//                        .foregroundColor(Color.white)
//                        .padding(.leading, 20)
//                        .padding(.trailing, 20)
//                        .padding(.top, 10)
//                        .padding(.bottom, 10)
//                        .background(Color("crimson"))
//                        .cornerRadius(8)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color("crimson"), lineWidth: 2)
//                        )
//
//                }
//                .padding(.top, 10)
        }
    }
}
