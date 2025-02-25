//
//  v1_notification.swift
//  Lupine
//
//  Created by blueb on 2/25/25.
//

import Foundation

public struct v1_notification: Codable {
	public var id: String
	public var type: String
	
	public var account: v1_user?
	public var status: v1_status?
	public var emoji: String?
	public var emoji_url: String?
	
	public var created_at: String
}
