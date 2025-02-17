//
//  MastodonApiResponses.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Foundation

class MastodonApiResponses {
	public struct oauth_token {
		public let access_token: String
		public let token_type: String
		public let scope: String
		public let created_at: String
	}

	public struct v1_verify_credentials {
		public let name: String
		public let website: String
		public let vapid_key: String
	}
	public struct v1_apps {
		public let id: String
		public let name: String
		public let website: String
		public let scopes: [String]
		public let redirect_uri: String
		public let client_id: String
		public let client_secret: String
		public let vapid_key: String
	}
}
