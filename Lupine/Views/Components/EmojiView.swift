//
//  EmojiView.swift
//  Lupine
//
//  Created by blueb on 2/20/25.
//

import CachedAsyncImage
import SwiftUI

struct EmojiView: View {
	@State var url: String? = ""
	@State var size: CGFloat? = 20.0

	var body: some View {
		CachedAsyncImage(
			url: URL(string: url ?? ""),
			urlCache: .emojiCache
		) { image in
			image.resizable().scaledToFill()
		} placeholder: {
			Rectangle().fill(.quaternary).clipShape(.rect(cornerRadius: 6))
		}
		.frame(height: size)
		.aspectRatio(contentMode: .fit)

	}
}

#Preview {
	EmojiView(url: "https://remlit.site/media/emoji/a2x7v8yok7s66m0a")
}
