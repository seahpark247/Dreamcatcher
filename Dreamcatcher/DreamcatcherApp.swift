//
//  DreamcatcherApp.swift
//  Dreamcatcher
//
//  Created by Seah Park on 3/8/25.
//

import AppIntents
import SwiftData
import SwiftUI

@main
struct DreamcatcherApp: App {
    @State private var dataController: DataController
    @State private var modelContainer: ModelContainer

    var body: some Scene {
        WindowGroup {
            ContentView(dataController: dataController)
        }
        .modelContainer(modelContainer)
    }

    init() {
        let modelContainer: ModelContainer

        do {
            modelContainer = try ModelContainer(for: Dream.self)
        } catch {
            print("Error loading ModelContainer; switching to in-memory storage.")
            let config = ModelConfiguration(isStoredInMemoryOnly: true)
            modelContainer = try! ModelContainer(for: Dream.self, configurations: config)
        }

        self._modelContainer = .init(initialValue: modelContainer)

        let dataController = DataController(modelContainer: modelContainer)
        self._dataController = .init(initialValue: dataController)

        AppDependencyManager.shared.add(dependency: dataController)
    }
}
