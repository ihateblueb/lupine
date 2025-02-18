//
//  v1_emoji.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//

import Foundation

public struct v1_emoji: Codable {
	public var shortcode: String
	public var static_url: String?
	public var url: String
	public var visible_in_picker: Bool = true
	public var category: String?
}
