//
//  v1_media_attachment.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//

import Foundation

public struct v1_media_attachment: Codable {
	public var id: String
	
	public var url: String
	public var remote_url: String?
	public var preiew_url: String?
	public var text_url: String?
	
	public var description: String?
	public var blurhash: String?
	public var type: String?
}
