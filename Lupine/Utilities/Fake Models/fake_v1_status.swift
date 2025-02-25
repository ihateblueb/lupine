//
//  fake_v1_status.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//

import Foundation

public func fake_v1_status() -> v1_status {
	return v1_status.init(
		id: "000000001",
		text: "test text post content !",
		uri: "http://localhost/@fake_v1_user/statuses/000000001",
		url: "http://localhost/@fake_v1_user/statuses/000000001",
		account: fake_v1_user(),
		created_at: "2025-01-05T02:17:12.978Z",
		visibility: "public",
		reactions: [
			v1_status__reaction.init(
				count: 4,
				me: false,
				name: "❤️"),
			v1_status__reaction.init(
				count: 9,
				me: false,
				name: "🪻"
			),
			v1_status__reaction.init(
				count: 2,
				me: false,
				name: "the",
				url: "https://booping.s3.us-east-005.backblazeb2.com/files/3d8faacc-cba4-4380-b753-c3ee5bc99d17.jpg"
			),
			v1_status__reaction.init(
				count: 2,
				me: true,
				name: "😼"
			),
		]
	)
}
