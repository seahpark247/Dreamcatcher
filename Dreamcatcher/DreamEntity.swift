//
//  DreamEntity.swift
//  Dreamcatcher
//
//  Created by Seah Park on 3/8/25.
//

import AppIntents
import CoreSpotlight
import Foundation

struct DreamEntity: IndexedEntity {
    var id: UUID
    var title: String
    var details: String
    var date: Date
    var imageURL: URL?

    var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = defaultAttributeSet
        attributeSet.contentDescription = details
        attributeSet.addedDate = date
        attributeSet.thumbnailURL = imageURL
        return attributeSet
    }

    static let typeDisplayRepresentation: TypeDisplayRepresentation = "Dream"
    static let defaultQuery = DreamEntityQuery()

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)", image: .init(systemName: "sparkles"))
    }
}

struct DreamEntityQuery: EnumerableEntityQuery {
    @Dependency var dataController: DataController

    func allEntities() async throws -> [DreamEntity] {
        try await dataController.dreamEntities()
    }

    func entities(for identifiers: [UUID]) async throws -> [DreamEntity] {
        try await dataController.dreamEntities(matching: #Predicate {
            identifiers.contains($0.uniqueID)
        })
    }
}
