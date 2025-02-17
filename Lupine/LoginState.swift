//
//  LoginState.swift
//  Lupine
//
//  Created by blueb on 2/16/25.
//

import Foundation
import SwiftData

@Model
final class LoginState {
	var loggedIn: Bool

	var domain: String?
	var token: String?

	init(timestamp: Date) {
		self.loggedIn = false
	}
}
