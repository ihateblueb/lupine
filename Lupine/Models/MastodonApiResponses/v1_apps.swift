//
//  v1_apps.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Foundation

public struct v1_apps: Codable {
	public var id: String
	public var name: String
	public var website: String?
	public var scopes: [String]
	public var redirect_uri: String
	public var client_id: String
	public var client_secret: String
	public var vapid_key: String?
}
