//
//  FlipcardApp.swift
//  Shared
//
//  Created by Frank on 11/5/21.
//

import SwiftUI

@main
struct FlipcardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
