//
//  TheSpecialKiwiApp.swift
//  TheSpecialKiwi
//
//  Created by Reyhan Ariq Syahalam on 13/08/24.
//

import SwiftUI
import SwiftData
import SDWebImageLottieCoder

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
    
    init() {
        // Register the Lottie coder
        SDImageCodersManager.shared.addCoder(SDImageLottieCoder.shared)
    }

    var body: some Scene {
        WindowGroup {
            NavigationView()
                .environmentObject(NavigationViewModel())
        }
        .modelContainer(sharedModelContainer)
    }
}
