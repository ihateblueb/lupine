//
//  NotificationView.swift
//  Lupine
//
//  Created by blueb on 2/25/25.
//

import SwiftUI

struct NotificationView: View {
	@State var notification: v1_notification

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				if notification.type == "favourite"
					&& notification.account != nil
				{
					Image(systemName: "star.fill")
						.foregroundColor(Color.yellow)

					AvatarView(url: notification.account!.avatar, size: 30.0)
					Text(
						"\(notification.account!.display_name ?? notification.account!.username) liked your post"
					)
				} else if notification.type == "reaction"
					&& notification.account != nil
				{
					if notification.emoji != nil {
						if notification.emoji_url != nil {
							EmojiView(url: notification.emoji_url!)
						} else {
							Text(notification.emoji!)
						}
					} else {
						Image(systemName: "plus")
							.foregroundColor(Color.accentColor)
					}

					AvatarView(url: notification.account!.avatar, size: 30.0)
					Text(
						"\(notification.account!.display_name ?? notification.account!.username) reacted to your post"
					)
				} else if notification.type == "reblog"
					&& notification.account != nil
				{
					Image(systemName: "arrow.2.squarepath")
						.foregroundColor(Color.green)

					AvatarView(url: notification.account!.avatar, size: 30.0)
					Text(
						"\(notification.account!.display_name ?? notification.account!.username) boosted your post"
					)
				}
			}

			if notification.status != nil {
				HStack {
					StatusView(status: notification.status!)
				}
			}
		}.padding(.vertical, 10.0).padding(.horizontal, 5.0)
	}
}

#Preview {
	NotificationView(notification: fake_v1_notification())
}
