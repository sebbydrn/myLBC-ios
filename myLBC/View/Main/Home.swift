//
//  Home.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/20/21.
//

import SwiftUI

struct Home: View {
    @State var showMenu = false
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        GeometryReader { geometry in
            
            ZStack(alignment: .leading) {
                
                MainView(showMenu: self.$showMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/1.5 : 0)
                    .disabled(self.showMenu ? true : false)
                
                if self.showMenu {
                    MenuView()
                        .frame(width: geometry.size.width/1.5)
                        .transition(.move(edge: .leading))
                }
                
            }
            .gesture(drag)
            
        }
        .navigationBarTitle("myLBC", displayMode: .inline)
        .navigationBarItems(leading: (
                                Button(action: {
                                    withAnimation {
                                        self.showMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                }
        ))
    }
}

struct MainView: View {
    @Binding var showMenu: Bool
    
    @State private var toggleComingSoon = false
    
    @StateObject var balance = balanceAPI()
    
    var body: some View {
        
        ScrollView {

            VStack {

                VStack {

                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {

                        Text("myBalance")
                            .font(.title2)

                    }

                    HStack {

                        VStack {
                            Text("Available")
                            Text(balance.availableBalance)
                        }

                        Spacer()

                        VStack {
                            Text("Current")
                            Text(balance.currentBalance)
                        }

                    }
                    .onAppear{
                        balance.getBalance()
                    }
                    .padding()
                    .padding(.top, -10)

                }
                .frame(maxWidth: .infinity)
                .padding(.trailing, 10)
                .padding(.leading, 10)
                .padding(.top, 10)
                .padding(.bottom, 0)
                .background(Color("crimson"))
                .foregroundColor(Color.white)

                VStack {

                    HStack {

                        NavigationLink(destination: TransactionHistory()) {
                            Image(systemName: "calendar")
                                .imageScale(.large)

                            Text("Transaction History")

                            Spacer()

                            Image(systemName: "arrow.right")
                        }

                    }
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity, alignment: .leading)

                }
                .padding()

                VStack {

                    HStack {

                        VStack {

                            Button(action: {
                                self.toggleComingSoon.toggle()
                            }) {
                                VStack {
                                    Image("cash-in")
                                        .resizable()
                                        .frame(width: 85, height: 85)
                                    Text("Cash In")
                                        .foregroundColor(Color.black)
                                }
                            }
                            .sheet(isPresented: $toggleComingSoon) {
                                ComingSoonSheet(showModal: self.$toggleComingSoon)
                            }

                        }
                        .padding()

                        VStack {

                            NavigationLink(destination: CashOut()) {

                                VStack {

                                    Image("cash-out")
                                        .resizable()
                                        .frame(width: 85, height: 85)
                                    Text("Cash Out")
                                        .foregroundColor(Color.black)

                                }

                            }

                        }
                        .padding()

                    }

                }

                VStack {

                    HStack {

                        VStack {

                            NavigationLink(destination: Transfer()) {

                                VStack {

                                    Image("remit")
                                        .resizable()
                                        .frame(width: 85, height: 85)
                                    Text("Transfer")
                                        .foregroundColor(Color.black)

                                }

                            }

                        }
                        .padding()

                        VStack {

                            Button(action: {
                                self.toggleComingSoon.toggle()
                            }) {
                                VStack {
                                    Image("buyload")
                                        .resizable()
                                        .frame(width: 85, height: 85)
                                    Text("Buy Load")
                                        .foregroundColor(Color.black)
                                }
                            }
                            .sheet(isPresented: $toggleComingSoon) {
                                ComingSoonSheet(showModal: self.$toggleComingSoon)
                            }

                        }
                        .padding()

                    }

                }

                VStack {

                    HStack {

                        VStack {

                            Button(action: {
                                self.toggleComingSoon.toggle()
                            }) {
                                VStack {
                                    Image("billspay")
                                        .resizable()
                                        .frame(width: 85, height: 85)
                                    Text("Pay Bills")
                                        .foregroundColor(Color.black)
                                }
                            }
                            .sheet(isPresented: $toggleComingSoon) {
                                ComingSoonSheet(showModal: self.$toggleComingSoon)
                            }

                        }
                        .padding()

                        VStack {
                            Image("LBCLogo")
                                .resizable()
                                .frame(width: 85, height: 85)
                            Text("LBC Card")
                        }
                        .padding()

                    }

                }

                VStack {

                    HStack {


                        VStack {

                            NavigationLink(destination: TrackTrace()) {

                                VStack {

                                    Image("LBCLogo")
                                        .resizable()
                                        .frame(width: 85, height: 85)
                                    Text("Cargo Tracking")
                                        .foregroundColor(Color.black)

                                }

                            }

                        }
                        .padding()

                    }

                }


                Spacer()

            }
            .navigationBarBackButtonHidden(true)

        }
        
    }
}
