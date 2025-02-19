//
//  Box.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//	https://stackoverflow.com/questions/73315816/swift-codable-struct-recursively-containing-itself-as-property
//

class Box<T: Codable>: Codable {
	let inner: T
	required init(from decoder: Decoder) throws {
		inner = try T(from: decoder)
	}

	func encode(to encoder: Encoder) throws {
		try inner.encode(to: encoder)
	}
}
