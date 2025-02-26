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
	@Environment(\.dismissWindow) var dismissWindow
	@Environment(\.openWindow) var openWindow

	@AppStorage("token") var token: String = ""

	var body: some Scene {
		WindowGroup(id: "Login") {
			LoginView()
		}.windowStyle(.hiddenTitleBar).defaultSize(width: 350, height: 400)

		// misc
		
		WindowGroup(id: "Debug") {
			DebugView()
		}
		WindowGroup(id: "Compose") {
			ComposeView()
		}.windowStyle(.hiddenTitleBar).defaultSize(width: 350, height: 400)

		// users
		
		WindowGroup(id: "User", for: lupine_user_window_params.self) { params in
			UserView(userId: params.wrappedValue?.userId ?? "")
		}.defaultSize(width: 500, height: 600)
		
		// main
		
		WindowGroup(id: "Main") {
			ContentView()
		}.commands {
			CommandGroup(after: .newItem) {
				Button("New Post") {
					openWindow(id: "Compose")
				}.keyboardShortcut("N", modifiers: [.command, .shift])
			}
		}
	}
}
