//
//  SignupAPI.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 6/26/21.
//

import Foundation

class SignupAPI: ObservableObject {
    func signup(
        email: String,
        extId: String,
        debitCardNumber: String,
        fname: String,
        mname: String,
        lname: String,
        suffix: String,
        maidenName: String,
        bdate: String,
        gender: Int,
        civilStatus: Int,
        nationality: String,
        unitNo: String,
        bldg: String,
        add1: String,
        add2: String,
        province: Int,
        city: Int,
        zip: Int,
        mobile: String,
        landline: String,
        occupation: String,
        company: String,
        tin: String,
        idNumber: String,
        idType: Int,
        idExpiry: String,
        idPic: String,
        custPic: String,
        completion: @escaping (String) -> ()) {
        
        guard let url = URL(string: "http://192.168.1.30:3000/lbcapi/ss/signup") else { return }
        
        let body: [String: Any] = ["email": email, "extId": extId, "debitCardNumber": debitCardNumber, "fname": fname, "mname": mname, "lname": lname, "suffix": suffix, "maidenName": maidenName, "bdate": bdate, "gender": gender, "civilStatus": civilStatus, "nationality": nationality, "unitNo": unitNo, "bldg": bldg, "add1": add1, "add2": add2, "province": province, "city": city, "zip": zip, "mobile": mobile, "landline": landline, "occupation": occupation, "company": company, "tin": tin, "idNumber": idNumber, "idType": idType, "idExpiry": idExpiry, "idPic": idPic, "custPic": custPic]
        
        let finalBody = try? JSONSerialization.data(withJSONObject: body)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = finalBody
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(Signup.self, from: data)
            
            if finalData?.message == "Your account has been successfully created" {
                DispatchQueue.main.async {
                    completion("Success")
                }
            } else {
                print("Cannot retrieve tracking details")
            }
        }.resume()
        
    }
}
