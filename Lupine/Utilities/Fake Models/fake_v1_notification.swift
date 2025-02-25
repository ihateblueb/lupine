//
//  fake_v1_notification.swift
//  Lupine
//
//  Created by blueb on 2/25/25.
//

public func fake_v1_notification() -> v1_notification {
	return v1_notification.init(
		id: "000000000",
		type: "favourite",
		account: fake_v1_user(),
		status: fake_v1_status(),
		created_at: "2025-01-05T02:17:12.978Z"
	)
}
