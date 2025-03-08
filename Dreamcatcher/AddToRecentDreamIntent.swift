//
//  AddToRecentDreamIntent.swift
//  Dreamcatcher
//
//  Created by Seah Park on 3/8/25.
//

import AppIntents
import Foundation

struct AddToRecentDreamIntent: AppIntent {
    @Dependency var dataController: DataController

    @Parameter var newText: String

    static let title: LocalizedStringResource = "Add to Recent Dream"

    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog {
        let recentDreams = try dataController.dreams(limit: 1)

        if let first = recentDreams.first {
            first.details.append(" \(newText)")
            try? first.modelContext?.save()
            return .result(dialog: "Done")
        } else {
            return .result(dialog: "You haven't logged any dreams yet.")
        }
    }
}
