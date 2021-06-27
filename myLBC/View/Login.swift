//
//  Login.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/17/21.
//

import SwiftUI
import CoreData
import Combine

class HttpAuth: ObservableObject {
    var didChange = PassthroughSubject<HttpAuth, Never>()
    
    @Published var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    var db:DBHelper = DBHelper()
    
    func checkDetails(email: String, password: String, secretKey: String) {
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/login") else { return }
        
        let body: [String: String] = ["email": email, "password": password, "secretKey": secretKey]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(ServerMessage.self, from: data)
            
            if finalData?.message == "User is authenticated!" {
                
                DispatchQueue.main.async {
                    print("User is authenticated")
                    
//                    self.db.deleteUsers()
                    
                    self.db.insertUser(
                        token: finalData!.result.token,
                        username: finalData!.result.userDetails.username,
                        fname: finalData!.result.userDetails.cifDtls.fname,
                        mname: finalData!.result.userDetails.cifDtls.mname,
                        lname: finalData!.result.userDetails.cifDtls.lname,
                        birthdate: finalData!.result.userDetails.cifDtls.birthdate,
                        nationality: finalData!.result.userDetails.cifDtls.nationality,
                        email: finalData!.result.userDetails.cifDtls.email,
                        gender: finalData!.result.userDetails.cifDtls.gender
                    )
                    
//                    print(finalData!.result.token)
                    
                    self.authenticated = true
                }
                
            } else {
                print("Incorrect username or password")
            }
            
        }.resume()
    }
}

struct ServerMessage: Codable {
    let id: String
    let message: String
    let result: ServerResult
}

struct ServerResult: Codable {
    let responseCode: Int
    let token: String
    let userDetails: ServerUserDetails
}

struct ServerUserDetails: Codable {
    let username: String
    let uid: Int
    let cifDtls: ServerUserDetailsCIF
    let priWallet: Int
}

struct ServerUserDetailsCIF: Codable {
    let info_id: Int
    let auth_id: Int
    let cust_type_id: Int
    let cust_no: String
    let external_id: String?
    let card_number: String?
    let fname: String
    let mname: String
    let lname: String
    let suffix: String
    let birthdate: String
    let gender: Int
    let civil_status: Int
    let nationality: String
    let mother_maiden_name: String
    let house_no: String
    let bldg: String
    let address1: String
    let address2: String
    let zip: Int
    let city: Int
    let province: Int
    let mobile: String
    let landline: String
    let email: String
    let occupation: String
    let company_name: String?
    let id_type: Int
    let id_number: String
    let id_expiry: String
    let id_photo: ServerIdPhotoDetails
    let cust_photo: ServerCustPhotoDetails
    let tin: String?
    let date_added: String
    let is_sub: Int
    let hash: String
    let gender_name: String
    let wallet_id: Int
    let acct_no: String
    let acct_desc: String
    let active: Int
}

struct ServerIdPhotoDetails: Codable {
    let type: String
}

struct ServerCustPhotoDetails: Codable {
    let type: String
}

struct Login: View {
    @State var username = "lemdoronio.24@gmail.com"
    @State var password = "ASDFgh11!!"
    @State var secretKey = "Loyalty2019"
    @State var isLinkActive = false
    
    @ObservedObject var userAuth = HttpAuth()
    
    @Namespace var animation
    
    var db:DBHelper = DBHelper()
    
    
    
    init() {
        DictionaryAPI().loadDictionaries()
//        db.deleteUsers()
//        getProvinces()
//        db.createUserTable()
    }

    var body: some View {
        
        if userAuth.authenticated {
            NavigationLink(destination: Home(), isActive: $userAuth.authenticated) {

            }
        } else {
            VStack {
                
                Image("LBCLogo")
                    .padding()
                
                CustomTextField(image: "person", title: "Username", showPassword: false, value: $username, animation: animation)
                
                CustomTextField(image: "lock", title: "Password", showPassword: false, value: $password, animation: animation)
                    .padding(.top, 5)
                
                HStack {
                    
                    RememberMeField(rememberMe: false)
                    
                    Spacer()
                        
                    ForgotPassword()
                    
                }
                .padding(.top, 10)
                .padding(.horizontal)
                
    //            NavigationLink(destination: Home(), isActive: $isLinkActive) {
    //                Button(action: {
    //                    print(self.username)
    //                    print(self.password)
    //
    //                    self.userAuth.checkDetails(email: self.username, password: self.password, secretKey: self.secretKey)
    //
    //                    if userAuth.authenticated {
    //                        print(userAuth.authenticated)
    //                        self.isLinkActive = true
    //                    }
    //                }) {
    //                    Text("LOGIN")
    //                        .foregroundColor(Color.white)
    //                }
    //                .padding(.leading, 20)
    //                .padding(.trailing, 20)
    //                .padding(.top, 10)
    //                .padding(.bottom, 10)
    //                .background(Color("crimson"))
    //                .cornerRadius(8)
    //                .overlay(
    //                    RoundedRectangle(cornerRadius: 8)
    //                        .stroke(Color("crimson"), lineWidth: 2)
    //                )
    //            }
    //            .padding(.top, 20)
                
//                if userAuth.authenticated {
//                    Text("Logged In")
//                } else {
//                    Text("Not logged in")
//                }
                
                
                Button(action: {
//                    print(self.username)
//                    print(self.password)

                    self.userAuth.checkDetails(email: self.username, password: self.password, secretKey: self.secretKey)
                }) {
                    Text("LOGIN")
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
                .padding(.top, 20)
                
                
                HStack {
                    Text("No account yet? Sign up")
                        .padding(.top, 10)
                        .padding(.trailing, 0)
                        .foregroundColor(Color.gray)
                    
                    NavigationLink(destination: RegisterForm()) {
                        Text("here !")
                    }
                    .padding(.top, 10)
                    .padding(.leading, -3)
                }
                
            }
            .navigationBarHidden(true)
        }
        
    }
}
