//
//  DreamEditor.swift
//  Dreamcatcher
//
//  Created by Seah Park on 3/8/25.
//

import CoreSpotlight
import ImagePlayground
import SwiftUI

struct DreamEditor: View {
    @Bindable var dream: Dream

    @State private var indexingTask: Task<Void, Error>?
    @State private var isShowingImagePlayground = false

    var body: some View {
        Form {
            Section("Describe your dream") {
                TextField("Dream details", text: $dream.details, axis: .vertical)
            }

            Section("Extra details") {
                LabeledContent("Intensity") {
                    Slider(value: $dream.intensity) {
                        Text("Intensity: \(dream.intensity.formatted())")
                    } minimumValueLabel: {
                        Image(systemName: "moon.zzz")
                    } maximumValueLabel: {
                        Image(systemName: "flame")
                    }
                }

                DatePicker("Date", selection: $dream.date)
            }

            Button("Image Playground", systemImage: "apple.image.playground") {
                isShowingImagePlayground = true
            }

            AsyncImage(url: dream.imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Text("Add an image of your dream.")
            }
        }
        .navigationTitle($dream.title)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: dream.title, indexDream)
        .onChange(of: dream.details, indexDream)
        .onChange(of: dream.imageURL, indexDream)
        .imagePlaygroundSheet(isPresented: $isShowingImagePlayground, concept: dream.details) { url in
            if let url = dream.imageURL {
                try? FileManager.default.removeItem(at: url)
            }

            let newURL = URL.documentsDirectory.appending(path: "\(UUID()).png")
            try? FileManager.default.moveItem(at: url, to: newURL)
            dream.imageURL = newURL
        }
    }

    func indexDream() {
        indexingTask?.cancel()

        indexingTask = Task {
            try await Task.sleep(for: .seconds(1))
            print("Indexing current dream")
            try await CSSearchableIndex.default().indexAppEntities([dream.entity])
        }
    }
}
