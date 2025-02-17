//
//  ContentView.swift
//  Lupine
//
//  Created by blueb on 2/16/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
	@Environment(\.openWindow) private var openWindow
    @Environment(\.modelContext) private var modelContext
	
	@Query var loginState: [LoginState];
    
	enum SidebarSelection: Hashable {
		case timeline
		case notifications
		case followrequests
		case search
		case drive
		case settings
	}
    
    @State var selection: Set<SidebarSelection> = Set([.timeline])
	
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
                    Label("Follow Requests", systemImage: "person.crop.circle.badge.plus")
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
            .navigationSplitViewColumnWidth(min: 150, ideal: 180)
        } detail: {
			switch selection {
				case [.settings]:
					SettingsView()
					
				default:
					if (loginState.first?.loggedIn ?? false) {
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
    }
}

#Preview {
    ContentView()
		.modelContainer(for: LoginState.self, inMemory: true)
}
