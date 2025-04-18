//
//  MemoSpotApp.swift
//  MemoSpot
//
//  Created by Mehmet Güneş Akgün on 25.07.2024.
//

import SwiftUI
import SwiftData

@main
struct MemoSpotApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Memo.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
