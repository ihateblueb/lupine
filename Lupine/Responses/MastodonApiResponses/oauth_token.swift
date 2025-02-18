//
//  oauth_token.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Foundation

public struct oauth_token: Codable {
	public let access_token: String
	public let token_type: String
	public let scope: String
	public let created_at: String
}
