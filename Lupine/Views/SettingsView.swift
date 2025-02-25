//
//  SettingsView.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import SwiftUI
import UserNotifications

struct SettingsView: View {
	@AppStorage("client_id") var client_id: String = ""
	@AppStorage("client_secret") var client_secret: String = ""
	@AppStorage("code") var code: String = ""
	@AppStorage("token") var token: String = ""

	@AppStorage("notificationsAllowed") var notificationsAllowed: Bool = false

	var body: some View {
		Form {
			Button(action: {
				print("SettingsView: Requested notification permissions")

				UNUserNotificationCenter
					.current()
					.requestAuthorization(options: [.alert, .badge, .sound]) {
						success, error in

						if success {
							print(
								"SettingsView: Notification permissions granted"
							)
							notificationsAllowed = true
						} else {
							debugPrint(error as Any)
							notificationsAllowed = false
						}
					}
			}) {
				Text("Request notification permissions")
			}

			Button(
				action: {
					print("SettingsView: Scheduled debug notification")

					let content = UNMutableNotificationContent()
					content.title = "Debug notification"
					content.subtitle = ":3"
					content.sound = .default
					
					let trigger = UNTimeIntervalNotificationTrigger(
						timeInterval: 1,
						repeats: false
					)
					
					let request = UNNotificationRequest(
						identifier: UUID().uuidString,
						content: content,
						trigger: trigger
					)
					
					UNUserNotificationCenter.current().add(request)
				}) {
					Text("Debug notification")
				}

			Button(action: {
				client_id = ""
				client_secret = ""
				code = ""
				token = ""

				print("SettingsView: Cleared login state.")
			}) {
				Text("Clear login state")
			}
		}
	}
}

#Preview {
	SettingsView()
}
