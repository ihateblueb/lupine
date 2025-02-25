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

	@State var cwToggled: Bool = false

	var body: some View {
		VStack(alignment: .leading) {
			if isReblog {
				HStack {
					Image(systemName: "arrow.2.squarepath")
						.foregroundColor(Color.gray)
					Text(
						"\(status.account.display_name ?? status.account.username) boosted"
					)
					.foregroundColor(Color.gray)
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

				if innerStatus!.spoiler_text != nil
					&& !(innerStatus!.spoiler_text!.isEmpty)
				{
					Group {
						HStack {
							Text(innerStatus!.spoiler_text!)
							Button(action: {
								cwToggled = !cwToggled
							}) {
								Text(
									"\(cwToggled ? "Hide" : "Show")"
								)
							}
						}

						if cwToggled {
							if innerStatus!.text != nil {
								Group {
									Text(innerStatus!.text!)
								}
							}
						}
					}
					.padding(.vertical, 5.0)
				} else {
					if innerStatus!.text != nil {
						Group {
							Text(innerStatus!.text!)
						}
						.padding(.vertical, 5.0)
					}
				}

				if innerStatus!.reactions != nil
					&& innerStatus!.reactions!.count > 0
				{
					HStack(alignment: .center, spacing: 5.0) {
						ForEach(0..<innerStatus!.reactions!.count) { value in
							HStack {
								HStack(spacing: 5.0) {
									// ((innerStatus!.reactions?[value] != nil) ? innerStatus!.reactions![value]!.url : nil) != nil
									if innerStatus!.reactions!.indices
										.contains(value) != nil
										? (innerStatus!.reactions![value]?.url
											!= nil) : false
									{
										EmojiView(
											url: innerStatus!.reactions![value]!
												.url)
									} else {
										Text(
											innerStatus!.reactions![value]!.name
										).font(.system(size: 16.0))
									}

									Text(
										"\(innerStatus!.reactions![value]!.count)"
									)
									.foregroundColor(
										innerStatus!.reactions![value]!.me
											? Color(
												nsColor: .controlAccentColor)
											: Color(
												nsColor: .labelColor
											)
									)
								}.padding(.all, 5.0)
							}.background(
								Color(
									nsColor: innerStatus!.reactions![value]!.me
										? .controlAccentColor
											.withAlphaComponent(0.25)
										: .secondarySystemFill)
							).cornerRadius(
								5
							)
						}
					}
				}

				HStack(alignment: .center, spacing: 25.0) {
					Button(action: {}) {
						HStack(alignment: .center, spacing: 5) {
							Image(systemName: "arrow.uturn.left")

							if innerStatus!.replies_count != nil
								&& innerStatus!.replies_count! > 0
							{
								Text("\(innerStatus!.replies_count!)")
							}
						}
					}.buttonStyle(.borderless)

					Button(action: {}) {
						HStack(alignment: .center, spacing: 5) {
							Image(systemName: "arrow.2.squarepath")

							if innerStatus!.reblogs_count != nil
								&& innerStatus!.reblogs_count! > 0
							{
								Text("\(innerStatus!.reblogs_count!)")
							}
						}
					}.buttonStyle(.borderless)

					Button(action: {}) {
						HStack(alignment: .center, spacing: 5) {
							Image(systemName: "star")

							if innerStatus!.favourites_count != nil
								&& innerStatus!.favourites_count! > 0
							{
								Text("\(innerStatus!.favourites_count!)")
							}
						}
					}.buttonStyle(.borderless)

					Button(action: {}) {
						HStack(alignment: .center, spacing: 5) {
							Image(systemName: "plus")
						}
					}.buttonStyle(.borderless)

					Button(action: {}) {
						HStack(alignment: .center, spacing: 5) {
							Image(systemName: "bookmark")
						}
					}.buttonStyle(.borderless)

					Button(action: {}) {
						HStack(alignment: .center, spacing: 5) {
							Image(systemName: "ellipsis")
						}
					}.buttonStyle(.borderless)
				}
			}
		}.padding(.vertical, 10.0).padding(.horizontal, 5.0).onAppear {
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
