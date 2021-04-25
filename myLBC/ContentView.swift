//
//  ContentView.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            
            Login()
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}
