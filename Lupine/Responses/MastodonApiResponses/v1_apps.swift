//
//  v1_apps.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Foundation

public struct v1_apps: Codable {
	public let id: String
	public let name: String
	public let website: String
	public let scopes: [String]
	public let redirect_uri: String
	public let client_id: String
	public let client_secret: String
	public let vapid_key: String
}
