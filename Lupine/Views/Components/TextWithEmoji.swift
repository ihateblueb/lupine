//
//  TextWithEmoji.swift
//  Lupine
//
//  Created by blueb on 2/25/25.
//

import SwiftUI

struct TextWithEmoji: View {
	@State var text: String?
	@State var emojis: [v1_emoji?]?
	
	struct TextWithEmojiElement {
		var type: String
		var content: String
	}
	
	@State var elements: [TextWithEmojiElement?] = []
	
	func splitUp() {
		
	}
	
	var body: some View {
		Group {
			Text("")
		}.onAppear {
			splitUp()
		}
	}
}

#Preview {
	TextWithEmoji()
}
