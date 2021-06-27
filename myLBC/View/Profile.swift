//
//  Profile.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/25/21.
//

import SwiftUI

struct ProfileDetails: Identifiable {
    let id = UUID()
    let label: String
    let data: String
}

struct ProfileDetailsRow: View {
    var profile: ProfileDetails
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(profile.label)
                .foregroundColor(Color.gray)
                .bold()
            
            Text(profile.data)
            
        }
        .padding(.top, 10)
        .padding(.bottom, 10)
        
    }
}

struct Profile: View {
    @State private var toggleEnterPin = false
    
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    var gender = ""
    
    init() {
        userAccount = db.readUser(id: 3)
        
        if userAccount[0].gender == 1 {
            gender = "Male"
        } else {
            gender = "Female"
        }
    }
    
    func isodateFromString(_ isoDate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        let theDate = formatter.date(from: isoDate)!
        
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: theDate)
    }
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                
                Button(action: {
                    self.toggleEnterPin.toggle()
                }) {
                    HStack {
                        
                        Image(systemName: "pencil")
                        
                        Text("EDIT MY PROFILE")
                        
                    }
                }
                .sheet(isPresented: $toggleEnterPin) {
                    EnterPin(showModal: self.$toggleEnterPin)
                }
                .padding(.top, 15)
                
            }
            .padding(.top, 40)
            
            VStack {
                
                let profileData = [
                    ProfileDetails(label: "NAME", data: "\(userAccount[0].fname) \(userAccount[0].lname)"),
                    ProfileDetails(label: "BIRTH DATE", data: "\(isodateFromString(userAccount[0].birthdate))"),
                    ProfileDetails(label: "NATIONALITY", data: "\(userAccount[0].nationality)"),
                    ProfileDetails(label: "EMAIL", data: "\(userAccount[0].email)"),
                    ProfileDetails(label: "SEX", data: "\(gender)"),
                ]
                    
                List(profileData) { profile in
                    
                    ProfileDetailsRow(profile: profile)
                    
                }
                
            }
            .padding(.top, 20)
            
            VStack {
                
                Text("FOR ENHANCED SECURITY, KEEP YOUR ACCOUNT DETAILS UP TO DATE")
                    .italic()
                    .foregroundColor(Color.gray)
                
            }
            .padding(.top, 15)
            
            Spacer()
            
        }
        .navigationTitle("PERSONAL INFO")
        
    }
}
