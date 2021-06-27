//
//  RegisterForm2.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/19/21.
//

import SwiftUI

struct RegisterForm2: View {
    @Binding var fname: String
    @Binding var mname: String
    @Binding var lname: String
    @Binding var maidenName: String
    @Binding var suffix: String
    @Binding var gender: Int
    @Binding var civilStatus: Int
    @Binding var nationality: String
    @Binding var bdate: Date
    @State var unitNo = ""
    @State var building = ""
    @State var address1 = ""
    @State var address2 = ""
    @State var zipCode = ""
    @State var mobile = ""
    @State var landline = ""
    @State var email = ""
    @State var region = ""
    
    @State var selectedProvince = Provinces(province_id: 0, province_name: "", region: "")
    @State var selectedCity = Cities(city_id: 0, city_name: "", province: 0)
    
    var db: DBHelper = DBHelper()
    
    @State var provinces: [Provinces] = []
    @State var cities: [Cities] = []
    
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
            Picker(selection: $selectedProvince, label: Text("Province")) {
                ForEach(self.provinces, id: \.self) { item in
                    Text(item.province_name)
                }
            }
            .onAppear {
                self.provinces = db.getProvinces()
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background(Color.white)
            .border(Color.gray, width: 2)
            .padding(.top)
            .animation(.linear)
            .onChange(of: selectedProvince, perform: { value in
                self.region = value.region
                self.selectedCity = Cities(city_id: 0, city_name: "", province: 0)
                self.cities = db.getCity(province_id: value.province_id)
            })
            
            // Municipality field here
            Picker(selection: $selectedCity, label: Text("Municipality")) {
                ForEach(self.cities, id: \.self) { item in
                    Text(item.city_name)
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
        .navigationBarTitle("Sign Up", displayMode: .large)
        
        VStack(alignment: .center) {
            NavigationLink(destination: RegisterForm3(
                fname: self.$fname,
                mname: self.$mname,
                lname: self.$lname,
                maidenName: self.$maidenName,
                suffix: self.$suffix,
                gender: self.$gender,
                civilStatus: self.$civilStatus,
                nationality: self.$nationality,
                bdate: self.$bdate,
                unitNo: self.$unitNo,
                bldg: self.$building,
                add1: self.$address1,
                add2: self.$address2,
                province: self.$selectedProvince.province_id,
                city: self.$selectedCity.city_id,
                zip: self.$zipCode,
                mobile: self.$mobile,
                landline: self.$landline,
                email: self.$email
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
