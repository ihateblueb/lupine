//
//  ContentView.swift
//  Lupine
//
//  Created by blueb on 2/16/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
	@Environment(\.openWindow) private var openWindow
	@Environment(\.modelContext) private var modelContext

	@AppStorage("client_id") var client_id: String = ""
	@AppStorage("client_secret") var client_secret: String = ""
	@AppStorage("token") var token: String = ""

	enum SidebarSelection: Hashable {
		case timeline
		case notifications
		case followrequests
		case search
		case drive
		case settings
	}

	@State var selection: Set<SidebarSelection> = Set([.timeline])

	func sidebarSelectionToString(selection: Set<SidebarSelection>) -> String {
		switch selection {
		case [.timeline]:
			return "Timeline"
		case [.notifications]:
			return "Notifications"
		case [.followrequests]:
			return "Follow Requests"
		case [.search]:
			return "Search"
		case [.drive]:
			return "Drive"
		case [.settings]:
			return "Settings"
		default:
			return "Unknown"
		}
	}

	func login() {
		print("login hit")
	}

	var body: some View {
		NavigationSplitView {
			List(selection: $selection) {
				NavigationLink(value: SidebarSelection.timeline) {
					Label("Timeline", systemImage: "house")
				}
				NavigationLink(value: SidebarSelection.notifications) {
					Label("Notifications", systemImage: "bell")
				}
				NavigationLink(value: SidebarSelection.followrequests) {
					Label(
						"Follow Requests",
						systemImage: "person.crop.circle.badge.plus")
				}
				NavigationLink(value: SidebarSelection.search) {
					Label("Search", systemImage: "magnifyingglass")
				}
				NavigationLink(value: SidebarSelection.drive) {
					Label("Drive", systemImage: "cloud")
				}
				NavigationLink(value: SidebarSelection.settings) {
					Label("Settings", systemImage: "gear")
				}
			}
			.navigationSplitViewColumnWidth(min: 160, ideal: 200)
			Group {
				Text("Account")
			}
			.padding(.all)
		} detail: {
			switch selection {
			case [.settings]:
				SettingsView()

			default:
				if !token.isEmpty {
					switch selection {
					case [.timeline]:
						TimelineView()

					default:
						Text("Unknown view")
					}
				} else {
					Text("Not logged in")
					Button(action: {
						openWindow(id: "LoginView")
					}) {
						Text("Log in")
					}
				}
			}
		}
		.navigationTitle(
			sidebarSelectionToString(selection: selection)
		)
	}
}

#Preview {
	ContentView()
		.modelContainer(for: LoginState.self, inMemory: true)
}
