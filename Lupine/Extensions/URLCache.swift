//
//  URLCache.swift
//  Lupine
//
//  Created by blueb on 2/19/25.
//

import Foundation

extension URLCache  {
	static let avatarCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
	static let mediaAttachmentCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
