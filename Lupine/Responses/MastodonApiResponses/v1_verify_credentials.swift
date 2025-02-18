//
//  v1_verify_credentials.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Foundation

public struct v1_verify_credentials: Codable {
	public let name: String
	public let website: String
	public let vapid_key: String
}
