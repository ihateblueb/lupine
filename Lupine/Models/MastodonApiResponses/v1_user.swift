//
//  v1_user.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//

import Foundation

public struct v1_user: Codable {
	public var id: String

	public var username: String
	public var acct: String
	public var fqn: String
	public var display_name: String?
	public var locked: Bool = false
	public var created_at: String

	public var followers_count: Int = 0
	public var following_count: Int = 0
	public var statuses_count: Int = 0

	public var note: String?
	public var url: String
	public var uri: String

	public var avatar: String?
	public var avatar_static: String?
	public var avatar_description: String?

	public var header: String?
	public var header_static: String?
	public var header_description: String?

	public var moved: String?
	public var bot: Bool = false

	public var fields: [v1_user__fields?]?
	public var source: v1_user__source?
	public var emojis: [v1_emoji?]?
}

public struct v1_user__fields: Codable {
	public var name: String?
	public var value: String?
	public var verified_at: String?
}

public struct v1_user__source: Codable {
	public var language: String?
	public var note: String?
	public var privacy: String?
	public var sensitive: Bool = false
	public var fields: [v1_user__fields?]?
	public var follow_requests_count: Int = 0
}
