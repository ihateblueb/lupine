//
//  fake_v1_user.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//

import Foundation

public func fake_v1_user() -> v1_user {
	return v1_user.init(
		id: "000000000",
		username: "fake_v1_user",
		acct: "fake_v1_user",
		fqn: "fake_v1_user@localhost",
		created_at: "2025-01-05T02:17:12.978Z",
		url: "http://localhost/@fake_v1_user",
		uri: "http://localhost/@fake_v1_user",
		avatar: "https://avatars.githubusercontent.com/u/118416443?v=4"
	)
}
