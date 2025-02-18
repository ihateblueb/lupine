//
//  LupineApp.swift
//  Lupine
//
//  Created by blueb on 2/16/25.
//

import SwiftData
import SwiftUI

@main
struct LupineApp: App {
	@AppStorage("token") var token: String = ""

	var body: some Scene {
		WindowGroup {
			LoginView()
		}

		WindowGroup {
			ContentView()
		}
	}
}
