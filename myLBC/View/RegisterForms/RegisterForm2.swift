//
//  RegisterForm2.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/19/21.
//

import SwiftUI

struct RegisterForm2: View {
    @State var unitNo = ""
    @State var building = ""
    @State var address1 = ""
    @State var address2 = ""
    @State var zipCode = ""
    @State var mobile = ""
    @State var landline = ""
    @State var email = ""
    
    @State private var provinceIndex = 0
    @State private var municipalityIndex = 0
    
    var provinces = ["Nueva Ecija"]
    var municipalities = ["Cabanatuan City", "Science City of Munoz", "Talavera", "San Jose City"]
    
    @Namespace var animation
    
    var body: some View {
        
        HStack {
            Text("Primary Details >")
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
            Text("Address & Contact >")
                .foregroundColor(Color.blue)
                .font(.system(size: 14))
            Text("Identification")
                .foregroundColor(Color.gray)
                .font(.system(size: 14))
        }
            
        Form {
                
            CustomTextFieldReg(image: "mappin", title: "House / Unit No", showPassword: false, value: $unitNo, animation: animation)
        
            CustomTextFieldReg(image: "mappin", title: "Building / Condo / Subdivision", showPassword: false, value: $building, animation: animation)
            
            CustomTextFieldReg(image: "mappin", title: "Address 1", showPassword: false, value: $address1, animation: animation)
            
            CustomTextFieldReg(image: "mappin", title: "Address 2", showPassword: false, value: $address2, animation: animation)
            
            CustomTextFieldReg(image: "mappin", title: "Zip Code", showPassword: false, value: $zipCode, animation: animation)
            
            
            // Province field here
            Picker(selection: $provinceIndex, label: Text("Province")) {
                ForEach(0 ..< provinces.count) {
                    Text(self.provinces[$0]).tag($0)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            
            // Municipality field here
            Picker(selection: $municipalityIndex, label: Text("Municipality")) {
                ForEach(0 ..< municipalities.count) {
                    Text(self.municipalities[$0]).tag($0)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            
            CustomTextFieldReg(image: "iphone", title: "Mobile", showPassword: false, value: $mobile, animation: animation)
            
            CustomTextFieldReg(image: "phone", title: "Landline", showPassword: false, value: $landline, animation: animation)
            
            CustomTextFieldReg(image: "envelope", title: "Email", showPassword: false, value: $email, animation: animation)
                .padding(.bottom, 10)
            
        }
        .navigationTitle(Text("Sign Up"))
        
        VStack(alignment: .center) {
            NavigationLink(destination: RegisterForm3()) {
                
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
