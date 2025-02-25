//
//  NotificationsView.swift
//  Lupine
//
//  Created by blueb on 2/25/25.
//

import SwiftUI

struct NotificationsView: View {
	@AppStorage("domain") var domain: String = ""
	@AppStorage("token") var token: String = ""

	@State private var timelineData: [lupine_timeline_element] = []

	func addToTimeline(notification: v1_notification) {
		timelineData.append(
			lupine_timeline_element.init(
				id: notification.id,
				type: "notification",
				notification: notification
			))
	}

	func getTimeline(max_id: String? = nil) {
		let decoder = JSONDecoder()

		HttpClient()
			.get(
				url:
					"https://\(domain)/api/v1/notifications\(max_id != nil ? "?max_id=" + max_id! : "")",
				authenticate: true
			).response { response in
				if response.data == nil {
					print(
						"NotificationsView getTimeline: response.data is nil!")
					return
				}

				do {
					try decoder.decode(
						[v1_notification].self,
						from: response.data!
					).forEach { notification in
						addToTimeline(notification: notification)
					}
				} catch {
					debugPrint(error)
					print(
						"NotificationsView getTimeline: failed to decode response.data to v1_status"
					)
					return
				}
			}
	}

	var body: some View {
		if !timelineData.isEmpty {
			List {
				ForEach(timelineData) { data in
					if data.type == "notification" {
						NotificationView(notification: data.notification!)
					}
				}
				
				Group {
					ProgressView()
				}.onAppear {
					let lastElement = timelineData.last
					if lastElement != nil && lastElement!.type == "notification" {
						getTimeline(max_id: lastElement!.notification!.id)
					}
				}
			}
		} else {
			ProgressView().onAppear {
				getTimeline()
			}
		}
	}
}

#Preview {
	NotificationsView()
}
