//
//  LoginView.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Foundation
import SwiftData
import SwiftUI
import Alamofire

struct LoginView: View {
	@Environment(\.modelContext) private var modelContext

	@State private var domain: String = ""
	@State private var token: String = ""

	func attemptLogin() async {
		let decoder = JSONDecoder()

		struct AppsBody: Encodable {
			public let scopes = [
				"read", "write", "push",
			]
			public let client_name = "Lupine for macOS"
			public let website = "https://github.com/ihateblueb/lupine"
			public let redirect_uris = "urn:ietf:wg:oauth:2.0:oob"  // lupine-redirect-uri://
		}

		HttpClient().post(
			url: "https://\(domain)/api/v1/apps", body: AppsBody()).response { response in
				if ((response.data == nil)) {
					print("LoginView AttemptLogin: appsResponse.data is nil!")
					return
				}
				
				let appsData: v1_apps
				do {
					appsData = try decoder.decode(
						v1_apps.self,
						from: response.data!
					)
				} catch { return }
				
				print("hi! the client id is \(appsData.client_id)")
			}
	}

	var body: some View {
		TextField("Instance domain", text: $domain)
			.padding([.top, .leading, .trailing])
		Button(action: {
			Task {
				print("LoginView Go: \(domain)")
				await attemptLogin()
			}
		}) {
			Text("Go")
		}
		.padding([.leading, .trailing])

		TextField("Token", text: $token)
			.padding([.top, .leading, .trailing])
		Button(action: {
			Task {
				print("LoginView Go: \(domain)")
				await attemptLogin()
			}
		}) {
			Text("Finish")
		}
		.padding([.bottom, .leading, .trailing])
	}
}

#Preview {
	LoginView()
		.modelContainer(for: LoginState.self, inMemory: true)
}
