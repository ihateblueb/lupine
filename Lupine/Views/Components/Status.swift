//
//  Status.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//

import SwiftUI

struct Status: View {
	@State var status: v1_status

	var body: some View {
		VStack(alignment: .leading) {
			HStack(alignment: .center) {
				AvatarView(url: status.account.avatar, size: 40.0)
					.padding(.trailing, 5.0)

				VStack(alignment: .leading) {
					Text(status.account.display_name ?? status.account.username)
						.lineLimit(2)
					Text("@\(status.account.fqn)")
						.font(.caption)
						.lineLimit(1)
				}.frame(maxWidth: .infinity, alignment: .leading)
			}

			if status.text != nil {
				Group {
					Text(status.text!)
				}
				.padding(.vertical, 2.0)
			}
		}.padding(.all, 5.0)
	}
}

#Preview {
	Status(
		status: fake_v1_status()
	)
}

