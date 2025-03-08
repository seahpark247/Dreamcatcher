//
//  Dream.swift
//  Dreamcatcher
//
//  Created by Seah Park on 3/8/25.
//

import AppIntents
import Foundation
import SwiftData

@Model
class Dream {
    var uniqueID = UUID()
    var title: String
    var details: String
    var intensity: Double
    var date: Date
    var imageURL: URL?

    var entity: DreamEntity {
        .init(id: uniqueID, title: title, details: details, date: date, imageURL: imageURL)
    }

    init(title: String, details: String, intensity: Double, date: Date) {
        self.title = title
        self.details = details
        self.intensity = intensity
        self.date = date
    }
}
