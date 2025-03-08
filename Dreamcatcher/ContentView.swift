//
//  ContentView.swift
//  Dreamcatcher
//

import SwiftUI
import CoreSpotlight

struct ContentView: View {
    @Bindable var dataController: DataController
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack(path: $dataController.path) {
            DreamList(searchText: dataController.searchText)
                .searchable(text: $dataController.searchText)
                .navigationTitle("Dreamcatcher")
                .navigationDestination(for: Dream.self, destination: DreamEditor.init)
                .toolbar {
                    Button("Add Dream", systemImage: "plus", action: newDream)

                    Button("Add Samples", action: addSamples)
                }
        }
    }

    func newDream() {
        let dream = Dream(title: "New dream", details: "", intensity: 0.5, date: .now)
        modelContext.insert(dream)
        dataController.path = [dream]
    }

    func addSamples() {
        let first = Dream(
            title: "The Homework Heist",
            details: "I snuck into a secret vault, only to find it was filled with overdue homework. The alarms blared, and a librarian started chasing me with a ruler.",
            intensity: 0.85,
            date: Date.now
        )

        let second = Dream(
            title: "Toothpaste Tango",
            details: "I was in a ballroom dance competition, but my partner was a giant tube of toothpaste. Every time I twirled, minty foam sprayed everywhere.",
            intensity: 0.2,
            date: Date.now
        )

        let third = Dream(
            title: "Cow on a Plane",
            details: "I boarded a flight, but my seatmate was a very polite, well-dressed cow reading a newspaper. The in-flight meal was just grass.",
            intensity: 0,
            date: Date.now
        )

        let fourth = Dream(
            title: "The Invisible Trousers",
            details: "I confidently walked into an important meeting – until I realized my trousers were invisible! No one seemed to care, except for a very judgmental duck.",
            intensity: 0.5,
            date: Date.now
        )

        let fifth = Dream(
            title: "Spaghetti Rain",
            details: "It started raining spaghetti, and people opened umbrellas to shield themselves from the incoming meatballs. I tried to eat my way home but got too full.",
            intensity: 0.7,
            date: Date.now
        )

        try? modelContext.delete(model: Dream.self)
        modelContext.insert(first)
        modelContext.insert(second)
        modelContext.insert(third)
        modelContext.insert(fourth)
        modelContext.insert(fifth)
        
        try? modelContext.save()

        Task {
            try await CSSearchableIndex.default().indexAppEntities([first.entity, second.entity, third.entity, fourth.entity, fifth.entity])
        }
    }
}

