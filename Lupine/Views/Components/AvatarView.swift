//
//  AvatarView.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import SwiftUI

struct AvatarView: View {
	@State var url: String? = ""
	@State var alt: String? = ""
	@State var size: CGFloat? = 35.0

	var body: some View {
		AsyncImage(url: URL(string: url ?? "")) { image in
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
