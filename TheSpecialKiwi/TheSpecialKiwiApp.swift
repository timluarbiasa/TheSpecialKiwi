//
//  TheSpecialKiwiApp.swift
//  TheSpecialKiwi
//
//  Created by Reyhan Ariq Syahalam on 13/08/24.
//

import SwiftUI
import SwiftData

@main
struct TheSpecialKiwiApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            let movementBounds = CGRect(x: 0, y: 0, width: 300, height: 300)
            let viewModel = EyeContactStageViewModel(movementBounds: movementBounds)
            EyeContactStageView(viewModel: viewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
