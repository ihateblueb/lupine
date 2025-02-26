//
//  AvatarView.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import CachedAsyncImage
import SwiftUI

struct AvatarView: View {
	@Environment(\.dismissWindow) var dismissWindow
	@Environment(\.openWindow) var openWindow

	@State var user: v1_user?
	@State var size: CGFloat? = 35.0

	var body: some View {
		if user != nil {

			Button(
				action: {
					print("AvatarView Button clicked")
					openWindow(
						id: "User",
						value: lupine_user_window_params(
							userId: user?.id ?? "")
					)
				}) {
					CachedAsyncImage(
						url: URL(string: user!.avatar ?? ""),
						urlCache: .avatarCache
					) { image in
						image.resizable().clipShape(.rect(cornerRadius: 6))
					} placeholder: {
						Rectangle().fill(.quaternary).clipShape(
							.rect(cornerRadius: 6))
					}
					.frame(width: size, height: size)
				}.buttonStyle(.borderless)

		} else {
			Rectangle().fill(.quaternary).clipShape(.rect(cornerRadius: 6))
		}
	}
}

#Preview {
	AvatarView(user: fake_v1_user())
}
