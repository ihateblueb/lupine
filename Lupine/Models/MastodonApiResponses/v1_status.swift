//
//  v1_status.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//

import Foundation

public struct v1_status: Codable {
	public var id: String
	
	public var text: String?
	public var content: String?
	
	public var uri: String
	public var url: String
	
	public var account: v1_user
	
	public var in_reply_to_id: String?
	public var in_reply_to_account_id: String?
	
	//public var reblog: String?
	//public var quote: String?
	//public var quote_id: String?
	//public var content_type: String?
	
	public var created_at: String
	public var edited_at: String?
	
	public var replies_count: Int? = 0
	public var reblogs_count: Int? = 0
	public var favourites_count: Int? = 0
	
	public var reblogged: Bool? = false
	public var favourited: Bool? = false
	public var bookmarked: Bool? = false
	public var pinned: Bool? = false
	
	public var muted: Bool? = false
	public var sensitive: Bool? = false
	
	public var spoiler_text: String?
	public var visibility: String
	
	public var mentions: [v1_status__mention?]?
	public var media_attachments: [v1_media_attachment?]?
	public var emojis: [v1_emoji?]?
	public var reactions: [v1_status__reaction?]?
	public var tags: [v1_status__tag?]?
	
	public var card: String?
	public var application: String?
	public var language: String?
}

public struct v1_status__poll: Codable {
	public var expires_as: String?
	public var expired: Bool? = false
	public var multiple: Bool? = false
	
	public var votes_count: Int? = 0
	public var voters_count: Int? = 0
	public var voted: Bool? = false
	
	public var own_votes: [Int?]?
	public var options: [v1_status__poll__options]
}

public struct v1_status__poll__options: Codable {
	public var id: String
	public var title: String
	public var votes_count: Int? = 0
	public var emojis: [v1_emoji?]?
}

public struct v1_status__mention: Codable {
	public var id: String
	public var username: String
	public var acct: String
	public var url: String
}

public struct v1_status__reaction: Codable {
	public var count: Int? = 0
	public var me: Bool? = false
	public var name: String
	public var url: String?
	public var static_url: String?
	public var accounts: [v1_user?]?
	public var account_ids: [String?]?
}

public struct v1_status__tag: Codable {
	public var name: String
	public var url: String
}
