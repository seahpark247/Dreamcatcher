//
//  OpenDreamIntent.swift
//  Dreamcatcher
//
//  Created by Seah Park on 3/8/25.
//

import AppIntents
import Foundation
import SwiftUI

struct OpenDreamIntent: AppIntent {
    static let title: LocalizedStringResource = "Open Dream"

    @Parameter
    var target: DreamEntity

    func perform() async throws -> some IntentResult & ProvidesDialog & ShowsSnippetView {
        return .result(
            dialog: "\(target.title)"
        ) {
            VStack {
                Image(systemName: "moon.zzz")
                    .font(.largeTitle)

                Text(target.details)
            }
            .padding()
        }
    }
}

//struct OpenDreamIntent: OpenIntent {
//    static let title: LocalizedStringResource = "Open Dream"
//
//    @Dependency var dataController: DataController
//
//    @Parameter
//    var target: DreamEntity
//
//    func perform() async throws -> some IntentResult {
//        try await dataController.select(entity: target)
//        return .result()
//    }
//}
