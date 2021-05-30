//
//  CompletedView.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI

struct Completed: Identifiable {
    let id = UUID()
    let date: String
    let action: String
    let transactionID: String
    let amount1: String
    let amount2: String
}

struct CompletedRow: View {
    var completed: Completed
    
    @State private var toggleTransactionDetail = false
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(completed.date)
                
                Text(completed.transactionID)
                
                Button(action: {
                    self.toggleTransactionDetail.toggle()
                }) {
                    Text(completed.transactionID)
                        .foregroundColor(Color.blue)
                }
                .sheet(isPresented: $toggleTransactionDetail) {
                    TransactionDetailSheet(showModal: self.$toggleTransactionDetail)
                }
                
            }
            .font(.system(size: 16))
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
                Text(completed.action)
                
                Text(completed.amount1)
                
                Text(completed.amount2)
                
            }
            .font(.system(size: 16))
            
        }
        
        .padding(.bottom, 10)
        
    }
}

struct CompletedView: View {
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    init() {
        let userCount = db.countUsers()
        userAccount = db.readUser(id: userCount)
        getCompletedTransactions()
    }
    
    func getCompletedTransactions() {
        let userToken = userAccount[0].token
        
        print(userToken)
        
        guard let url = URL(string: "http://ec2-54-251-121-234.ap-southeast-1.compute.amazonaws.com:3000/lbcapi/ss/getTransactions") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            
            let finalData = try? JSONDecoder().decode(TransactionMessage.self, from: data)
            
            print(finalData)
            
            if finalData?.message == "Transactions have been retrieved" {
                DispatchQueue.main.async {
                    
                }
            } else {
                print("Cannot retrieve transactions")
            }
        }.resume()
    }
    
    struct TransactionMessage: Codable {
        let id: String
        let message: String
        let result: TransactionResult
    }

    struct TransactionResult: Codable {
        let responseCode: Int
        var postedTrx: [postedTrxData] = []
        var pendingTrx: [pendingTrxData] = []
    }
    
    struct postedTrxData: Codable {
        let trx_id: Int
        let wallet_id: Int
        let trx_type_id: Int
//        let amount: String
//        let freight: String
//        let cod_fee: String
//        let rts: String
//        let other_fees: String
//        let net_amt: String
//        let service_fee: String
//        let trx_ref: String
//        let trx_ref_ext: String
//        let notes: String
//        let sender_id: Int
//        let receiver_id: Int
//        let receiver_wallet: Int
//        let trx_date: String
//        let date_posted: String
//        let status: Int
//        let branch_name: String
//        let branch_code: String
//        let date: String
//        let trxType: String
//        let trxTypeCode: String
//        let gross: String
//        let netAmt: String
//        let balance: String
//        let statusDesc: String
//        let trxRef: String
    }
    
    struct pendingTrxData: Codable {
        let trx_id: Int
        let wallet_id: Int
        let trx_type_id: Int
//        let amount: String
//        let freight: String
//        let cod_fee: String
//        let rts: String
//        let other_fees: String
//        let net_amt: String
//        let service_fee: String
//        let trx_ref: String
//        let trx_ref_ext: String
//        let notes: String
//        let sender_id: Int
//        let receiver_id: Int
//        let receiver_wallet: Int
//        let trx_date: String
//        let date_posted: String
//        let status: Int
//        let branch_name: String
//        let branch_code: String
//        let date: String
//        let trxType: String
//        let trxTypeCode: String
//        let gross: String
//        let netAmt: String
//        let balance: String
//        let statusDesc: String
//        let trxRef: String
    }
    
    var body: some View {
        
        let completedData = [
            Completed(date: "Nov 29, 2020 5:44:32 PM", action: "Cash-in", transactionID: "ABCDEFG1662", amount1: "1,000.00", amount2: "10,007.00"),
            Completed(date: "Nov 28, 2020 9:55:40 PM", action: "Cash-in", transactionID: "kr7SGhPI", amount1: "1,000.00", amount2: "10,007.00")
        ]
            
        List(completedData) { completed in
            
            CompletedRow(completed: completed)
            
        }
        
    }
}
