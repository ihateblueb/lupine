//
//  SettingsView.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import SwiftUI

struct SettingsView: View {
	@AppStorage("client_id") var client_id: String = ""
	@AppStorage("client_secret") var client_secret: String = ""
	@AppStorage("token") var token: String = ""

	var body: some View {
		Button(action: {
			client_id = ""
			client_secret = ""
			token = ""

			print("SettingsView: Cleared login state.")
		}) {
			Text("Clear login state")
		}
	}
}

#Preview {
	SettingsView()
}
