//
//  StatusView.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//

import SwiftUI

struct StatusView: View {
	@State var status: v1_status

	@State var isReblog: Bool = false
	@State var innerStatus: v1_status? = nil

	var body: some View {
		VStack(alignment: .leading) {
			if isReblog {
				HStack {
					Image(systemName: "arrow.2.squarepath")
					Text(
						"\(status.account.display_name ?? status.account.username) boosted"
					)
				}
			}

			if innerStatus != nil {
				HStack(alignment: .center) {
					AvatarView(
						url: innerStatus?.account.avatar,
						size: 40.0
					)
					.padding(.trailing, 5.0)

					VStack(alignment: .leading) {
						Text(
							innerStatus?.account.display_name
								?? innerStatus!.account.username
						)
						.lineLimit(2)
						Text("@\(innerStatus!.account.fqn)")
							.font(.caption)
							.lineLimit(1)
					}.frame(maxWidth: .infinity, alignment: .leading)

					VStack(alignment: .leading) {
						if innerStatus!.visibility == "public" {
							Image(systemName: "globe")
						} else if innerStatus!.visibility == "unlisted" {
							Image(systemName: "house")
						} else if innerStatus!.visibility == "private" {
							Image(systemName: "lock")
						} else if innerStatus!.visibility == "direct" {
							Image(systemName: "envelope")
						}
					}.frame(alignment: .trailing)
				}

				if innerStatus!.text != nil {
					Group {
						Text(innerStatus!.text!)
					}
					.padding(.vertical, 5.0)
				}

				HStack(alignment: .center) {
					Button(action: {}) {
						Text("Reply")
					}
					Button(action: {}) {
						Text("Boost")
					}
					Button(action: {}) {
						Text("Like")
					}
					Button(action: {}) {
						Text("React")
					}
					Button(action: {}) {
						Text("Bookmark")
					}
				}
			}
		}.padding(.all, 5.0).onAppear {
			isReblog = status.reblog != nil

			if isReblog {
				innerStatus = status.reblog!.inner
			} else {
				innerStatus = status
			}
		}
	}
}

#Preview {
	StatusView(
		status: fake_v1_status()
	)
}
