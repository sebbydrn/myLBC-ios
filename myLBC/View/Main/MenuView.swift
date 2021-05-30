//
//  MenuView.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/20/21.
//

import SwiftUI

struct MenuView: View {
    
    var db: DBHelper = DBHelper()
    var userAccount: [UserTable] = []
    
    init() {
        userAccount = db.readUser(id: 3)
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            VStack {
                HStack {
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 32.0, height: 32.0)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                }
                .padding(.top, 150)
                
                HStack {
//                    Text(userAccount[0].fname)
//                        .foregroundColor(Color.white)
//                        .font(.title)
//                    +
//                    Text(" ")
//                    +
//                        Text(userAccount[0].lname)
//                        .foregroundColor(Color.white)
//                        .font(.title)
                    
                    Spacer()
                }
                .padding(.top, 0)
            }
            .padding()
            .background(Color("crimson"))
            
            HStack {
                
                Image(systemName: "house")
                    .foregroundColor(Color.black)
                    .imageScale(.large)
                Text("Home")
                    .foregroundColor(Color.black)
                    .font(.headline)
                    .padding(.leading, 5)
                
            }
            .padding()
            .padding(.top, 10)
            
            
            HStack {
                
                NavigationLink(destination: Profile()) {
                    Image(systemName: "person")
                        .foregroundColor(Color.black)
                        .imageScale(.large)
                    Text("Profile")
                        .foregroundColor(Color.black)
                        .font(.headline)
                        .padding(.leading, 9)
                }
                
            }
            .padding()
            
            HStack {
                
                NavigationLink(destination: Security()) {
                    Image(systemName: "gearshape")
                        .foregroundColor(Color.black)
                        .imageScale(.large)
                    Text("Settings")
                        .foregroundColor(Color.black)
                        .font(.headline)
                        .padding(.leading, 5)
                }
                
                
            }
            .padding()
            
            HStack {
                
                NavigationLink(destination: Login()) {
                    Image(systemName: "arrowshape.turn.up.left")
                        .foregroundColor(Color.black)
                        .imageScale(.large)
                    Text("Logout")
                        .foregroundColor(Color.black)
                        .font(.headline)
                        .padding(.leading, 5)
                }
                
            }
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipped()
        .shadow(color: Color.gray, radius: 10, x: 0, y: 0)
        .edgesIgnoringSafeArea(.all)
        
    }
}
