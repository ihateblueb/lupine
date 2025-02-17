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

	@AppStorage("client_id") var client_id: String = ""
	@AppStorage("client_secret") var client_secret: String = ""
	@AppStorage("code") var code: String = ""
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
				case [.timeline]:
					TimelineView()
				case [.settings]:
					SettingsView()
					
				default:
					Text("Unknown view")
			}
		}
		.navigationTitle(
			sidebarSelectionToString(selection: selection)
		)
		.toolbar(content: {
			ToolbarItem() {
				Button(action: {
					print("new note")
				}) {
					Image(systemName: "square.and.pencil")
				}
			}
		})
	}
}

#Preview {
	ContentView()
}
