//
//  AvatarView.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import SwiftUI
import CachedAsyncImage

struct AvatarView: View {
	@State var url: String? = ""
	@State var alt: String? = ""
	@State var size: CGFloat? = 35.0

	var body: some View {
		CachedAsyncImage(
			url: URL(string: url ?? ""),
			urlCache: .avatarCache
		) { image in
			image.resizable().clipShape(.rect(cornerRadius: 6))
		} placeholder: {
			ProgressView()
		}
		.frame(width: size, height: size)

	}
}

#Preview {
	AvatarView()
}
