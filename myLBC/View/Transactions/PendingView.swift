//
//  PendingView.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/24/21.
//

import SwiftUI
import Foundation

struct PendingView: View {
    @State private var toggleTransactionDetail = false
    @State private var trxnRef: String = ""
    @State private var trxDate: String = ""
    @State private var trxBranch: String = ""
    @State private var trxGrossAmt: String = ""
    @State private var trxFreightFee: String = ""
    @State private var trxCodFee: String = ""
    @State private var trxRts: String = ""
    @State private var trxOtherFee: String = ""
    @State private var trxNetAmt: String = ""
    @State var pendingTrxs: [PendingTrx] = []
    
    func isodateFromString(_ isoDate: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        let theDate = formatter.date(from: isoDate)!
        
        formatter.dateFormat = "MMM d, yyyy h:mm a"
        return formatter.string(from: theDate)
    }
    
    var body: some View {
        List(pendingTrxs) { trx in
            HStack {
            
                VStack(alignment: .leading) {
                    
                    Text("\(isodateFromString(trx.trx_date)!)")
                    Text("\(trx.trx_ref)")
    
                    Button(action: {
                        self.toggleTransactionDetail.toggle()
                        self.trxnRef = trx.trx_ref
                        self.trxDate = isodateFromString(trx.trx_date)!
                        self.trxBranch = trx.branch_name ?? ""
                        self.trxGrossAmt = trx.gross
                        self.trxFreightFee = trx.freight ?? ""
                        self.trxCodFee = trx.cod_fee ?? ""
                        self.trxRts = trx.rts ?? ""
                        self.trxOtherFee = trx.other_fees ?? ""
                        self.trxNetAmt = trx.netAmt
                    }) {
                        Text("\(trx.trx_ref)")
                            .foregroundColor(Color.blue)
                    }
                    .sheet(isPresented: $toggleTransactionDetail) {
                        TransactionDetailSheet(
                            showModal: self.$toggleTransactionDetail,
                            trxnRef: self.$trxnRef,
                            trxDate: self.$trxDate,
                            trxBranch: self.$trxBranch,
                            trxGrossAmt: self.$trxGrossAmt,
                            trxFreightFee: self.$trxFreightFee,
                            trxCodFee: self.$trxCodFee,
                            trxRts: self.$trxRts,
                            trxOtherFee: self.$trxOtherFee,
                            trxNetAmt: self.$trxNetAmt
                            )
                    }
    
                }
                .font(.system(size: 16))
    
                Spacer()
    
                VStack(alignment: .trailing) {
    
                    Text("\(trx.trxType)")
                    Text("\(trx.amount)")
                    Text("\(trx.balance)")
    
                }
                .font(.system(size: 16))
    
            }
            .padding(.bottom, 10)
        }
        .onAppear {
            TransactionAPI().getPendingTransactions { (pendingTrxs) in
                self.pendingTrxs = pendingTrxs
            }
        }
        
    }
}

