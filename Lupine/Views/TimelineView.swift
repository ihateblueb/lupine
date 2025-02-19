//
//  Timeline.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import SwiftUI

struct TimelineView: View {
	@AppStorage("domain") var domain: String = ""
	@AppStorage("token") var token: String = ""

	public var timeline = "home"

	@State private var timelineData: [lupine_timeline_element] = []

	func addToTimeline(status: v1_status) {
		timelineData.append(
			lupine_timeline_element.init(
				id: status.id,
				type: "status",
				status: status
			))
	}

	func getTimeline(max_id: String? = nil) {
		let decoder = JSONDecoder()

		HttpClient()
			.get(
				url:
					"https://\(domain)/api/v1/timelines/\(timeline)\(max_id != nil ? "?max_id=" + max_id! : "")",
				authenticate: true
			).response { response in
				if response.data == nil {
					print("LoginView loginGetToken: response.data is nil!")
					return
				}

				do {
					try decoder.decode(
						[v1_status].self,
						from: response.data!
					).forEach { status in
						addToTimeline(status: status)
					}
				} catch {
					debugPrint(error)
					print(
						"LoginView loginGetToken: failed to decode response.data to v1_status"
					)
					return
				}
			}
	}

	func loadMoreIfNeeded(id: String) {
		let lastElement = timelineData.last
		
		if id == lastElement?.id {
			print("load more not needed")
		} else {
			print("load more needed")
			if lastElement != nil && lastElement!.type == "status" {
				getTimeline(max_id: lastElement!.status!.id)
			}
		}
	}

	var body: some View {
		if (!timelineData.isEmpty) {
			List(timelineData) { data in
				if data.type == "status" {
					StatusView(status: data.status!).task {
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
	TimelineView()
}
