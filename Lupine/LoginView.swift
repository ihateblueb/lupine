//
//  LoginView.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import Alamofire
import Foundation
import SwiftData
import SwiftUI

struct LoginView: View {
	@Environment(\.modelContext) private var modelContext

	@AppStorage("client_id") var client_id: String = ""
	@AppStorage("client_secret") var client_secret: String = ""
	@AppStorage("token") var token: String = ""

	@State private var domain: String = ""

	func loginGetToken(appsData: v1_apps) {
		let decoder = JSONDecoder()

		struct TokenBody: Encodable {
			public var client_id = ""
			public var client_secret = ""
			public let redirect_uris = "urn:ietf:wg:oauth:2.0:oob"  // lupine-redirect-uri://
			public let grant_type = "client_credentials"

			init(id: String, secret: String) {
				self.client_id = id
				self.client_secret = secret
			}
		}

		var authorizeUrl = "https://"
		authorizeUrl.append(domain)
		authorizeUrl.append("/oauth/authorize?client_id=")
		authorizeUrl.append(appsData.client_id)
		authorizeUrl.append("&scope=read+write+push")
		authorizeUrl.append("&redirect_uri=urn:ietf:wg:oauth:2.0:oob")
		authorizeUrl.append("&response_type=code")

		print(authorizeUrl)

		NSWorkspace.shared.open(URL(string: authorizeUrl)!)
	}

	func loginRegisterApp() {
		let decoder = JSONDecoder()

		struct AppsBody: Encodable {
			public let scopes = [
				"read", "write", "push",
			]
			public let client_name = "Lupine for macOS"
			public let website = "https://github.com/ihateblueb/lupine"
			public let redirect_uris = "urn:ietf:wg:oauth:2.0:oob"  // lupine-redirect-uri://
		}

		debugPrint(AppsBody.self)

		HttpClient().post(
			url: "https://\(domain)/api/v1/apps", body: AppsBody()
		).response { response in
			if response.data == nil {
				print("LoginView AttemptLogin Apps: response.data is nil!")
				return
			}

			let appsData: v1_apps
			do {
				appsData = try decoder.decode(
					v1_apps.self,
					from: response.data!
				)
			} catch { return }

			loginGetToken(appsData: appsData)
		}
	}

	func attemptLogin() async {
		loginRegisterApp()
	}

	func finishLogin() async {

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

		TextField("Code", text: $token)
			.padding([.top, .leading, .trailing])
		Button(action: {
			Task {
				print("LoginView Finish")
			}
		}) {
			Text("Finish")
		}
		.padding([.leading, .trailing])
	}
}

#Preview {
	LoginView()
		.modelContainer(for: LoginState.self, inMemory: true)
}
