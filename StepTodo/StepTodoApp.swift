//
//  StepTodoApp.swift
//  StepTodo
//
//  Created by 広瀬友哉 on 2023/09/28.
//

import SwiftUI
import SwiftData

@main
struct StepTodoApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
//            ContentView()
            TabUI()
//            TodoGraf()
        }
        .modelContainer(sharedModelContainer)
    }
}
