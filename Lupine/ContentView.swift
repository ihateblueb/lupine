//
//  ContentView.swift
//  Lupine
//
//  Created by blueb on 2/16/25.
//

import SwiftData
import SwiftUI
import UserNotifications

struct ContentView: View {
	@Environment(\.dismissWindow) var dismissWindow
	@Environment(\.openWindow) var openWindow

	@AppStorage("token") var token: String = ""
	@AppStorage("account") var account: v1_user? = nil

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
			HStack {
				AvatarView(
					user: account!
				).frame(alignment: .leading)

				VStack(alignment: .leading) {
					Text((account!.display_name ?? account!.display_name) ?? "")
						.lineLimit(1)
					Text("@\(account!.fqn)")
						.font(.caption)
						.lineLimit(1)
				}
				.frame(maxWidth: .infinity, alignment: .leading)
			}
			.padding(.all)
		} detail: {
			switch selection {
			case [.timeline]:
				TimelineView()
			case [.notifications]:
				NotificationsView()
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
			ToolbarItem {
				Button(action: {
					openWindow(id: "Compose")
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
