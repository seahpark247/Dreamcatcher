//
//  CountRecentDreamsIntent.swift
//  Dreamcatcher
//
//  Created by Seah Park on 3/8/25.
//

import AppIntents
import Foundation
import SwiftData

struct CountRecentDreamsIntent: AppIntent {
    static let title: LocalizedStringResource = "Count Recent Dreams"

    @Dependency var dataController: DataController

    func perform() async throws -> some IntentResult & ProvidesDialog & ReturnsValue<Int> {
        let dateCutOff = Calendar.current.date(byAdding: .month, value: -1, to: .now) ?? .now

        let dreams = try await dataController.dreamCount(matching: #Predicate {
            $0.date > dateCutOff
        })

        let message = AttributedString(localized: "You've had ^[\(dreams) dream](inflect: true).")

        return .result(
            value: dreams,
            dialog: "\(message)"
        )
    }
}
