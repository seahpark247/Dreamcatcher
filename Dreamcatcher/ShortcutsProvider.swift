//
//  ShortcutsProvider.swift
//  Dreamcatcher
//
//  Created by Seah Park on 3/8/25.
//

import AppIntents
import Foundation

struct ShortcutsProvider: AppShortcutsProvider {
    static let shortcutTileColor: ShortcutTileColor = .navy

    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: CountRecentDreamsIntent(),
            phrases: [
                "Count my recent dreams in \(.applicationName)"
            ],
            shortTitle: "Recent Dream Count",
            systemImageName: "bubbles.and.sparkles"
        )

        AppShortcut(
            intent: DreamReminderIntent(),
            phrases: [
                "Remind me of a \(.applicationName) dream"
            ],
            shortTitle: "Remind me of a dream",
            systemImageName: "memories"
        )

        AppShortcut(
            intent: AddToRecentDreamIntent(),
            phrases: [
                "Add to my most recent dream in \(.applicationName)"
            ],
            shortTitle: "Add to Recent Dream",
            systemImageName: "plus"
        )

        AppShortcut(
            intent: OpenDreamIntent(),
            phrases: [
                "Open a dream in \(.applicationName)"
            ],
            shortTitle: "Open a dream",
            systemImageName: "sparkles"
        )
    }
}
