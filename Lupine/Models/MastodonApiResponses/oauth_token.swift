//
//  oauth_token.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Foundation

public struct oauth_token: Codable {
	public var access_token: String
	public var token_type: String
	public var scope: String
	public var created_at: Int
}
