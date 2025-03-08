//
//  DreamReminderIntetn.swift
//  Dreamcatcher
//
//  Created by Seah Park on 3/8/25.
//

import AppIntents
import Foundation

struct DreamReminderIntent: AppIntent {
    @Dependency var dataController: DataController

    static let title: LocalizedStringResource = "Remind me of a dream"

    @Parameter var dream: DreamEntity

    func perform() async throws -> some IntentResult & ProvidesDialog {
        .result(dialog: "\(dream.details)")
    }
}
