//
//  LupineApp.swift
//  Lupine
//
//  Created by blueb on 2/16/25.
//

import SwiftData
import SwiftUI

@main
struct LupineApp: App {
	var sharedModelContainer: ModelContainer = {
		let schema = Schema([
			LoginState.self
		])
		let modelConfiguration = ModelConfiguration(
			schema: schema, isStoredInMemoryOnly: false)

		do {
			return try ModelContainer(
				for: schema, configurations: [modelConfiguration])
		} catch {
			fatalError("Could not create ModelContainer: \(error)")
		}
	}()

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
		.modelContainer(sharedModelContainer)

		WindowGroup(id: "LoginView") {
			LoginView()
		}
		.modelContainer(sharedModelContainer)
	}
}
