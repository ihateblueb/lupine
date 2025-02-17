//
//  LoginView.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import SwiftData
import SwiftUI

struct LoginView: View {
	@Environment(\.modelContext) private var modelContext

	@State private var domain: String = ""

	func attemptLogin() {
		let appsBody: [String: Any] = [
			"scopes": [
				"read", "write", "push",
			],
			"client_name": "Lupine for macOS",
			"website": "https://github.com/ihateblueb/lupine",
			"redirect_uris": "lupine-redirect-uri://",
		]

		let appsBodyJson = try? JSONSerialization.data(withJSONObject: appsBody)

		let appsResponse = HttpClient().post(
			url: "https://\(domain)/api/v1/apps", body: appsBodyJson)
	}

	var body: some View {
		TextField("Instance domain", text: $domain)
			.padding([.top, .leading, .trailing])

		Button(action: {
			print("LoginView Go: \(domain)")
			attemptLogin()
		}) {
			Text("Go")
		}
		.padding([.bottom, .leading, .trailing])
	}
}

#Preview {
	LoginView()
		.modelContainer(for: LoginState.self, inMemory: true)
}
