//
//  myLBCApp.swift
//  myLBC
//
//  Created by Lemuel Sebastien S. Doronio on 4/10/21.
//

import SwiftUI

@main
struct myLBCApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
