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
	@Environment(\.dismissWindow) var dismissWindow
	@Environment(\.openWindow) var openWindow

	@AppStorage("domain") var domain: String = ""
	@AppStorage("client_id") var client_id: String = ""
	@AppStorage("client_secret") var client_secret: String = ""
	@AppStorage("code") var code: String = ""
	@AppStorage("token") var token: String = ""

	@AppStorage("account") var account: v1_user? = nil

	@State private var appsData: v1_apps? = nil

	// todo: error ui

	func isLoggedIn() {
		if !token.isEmpty {
			print("LoginView isLoggedIn: logged in")

			dismissWindow()
			openWindow(id: "Main")
		} else {
			print("LoginView isLoggedIn: not logged in")
		}
	}

	func getAccount() {
		let decoder = JSONDecoder()

		if token.isEmpty {
			print("LoginView getAccount: token is empty!")
			return
		}

		HttpClient().get(
			url: "https://\(domain)/api/v1/accounts/verify_credentials",
			authenticate: true
		).response { response in
			debugPrint(response)

			if response.data == nil {
				print("LoginView getAccount: response.data is nil!")
				return
			}

			var accountData: v1_user

			do {
				accountData = try decoder.decode(
					v1_user.self,
					from: response.data!
				)
			} catch {
				debugPrint(error)
				print(
					"LoginView getAccount: failed to decode response.data to v1_user"
				)
				return
			}

			account = accountData

			isLoggedIn()
		}
	}

	func loginGetToken() {
		let decoder = JSONDecoder()

		if appsData == nil {
			print("LoginView loginGetToken: appsData is nil!")
			return
		}

		if client_id == nil || client_secret == nil {
			print(
				"LoginView loginGetToken: client_id and/or client_secretis nil!"
			)
			return
		}

		if code.isEmpty {
			print("LoginView loginGetToken: code is empty!")
			return
		}

		struct CodeBody: Encodable {
			public let scope = [
				"read", "write", "push",
			]
			public let redirect_uri = "urn:ietf:wg:oauth:2.0:oob"  // lupine-redirect-uri://
			public let grant_type = "authorization_code"
			public var client_id = ""
			public var client_secret = ""
			public var code = ""

			init(id: String, secret: String, code: String) {
				self.client_id = id
				self.client_secret = secret
				self.code = code
			}
		}

		HttpClient().post(
			url: "https://\(domain)/oauth/token",
			body: CodeBody(
				id: client_id,
				secret: client_secret,
				code: code
			)
		).response { response in
			if response.data == nil {
				print("LoginView loginGetToken: response.data is nil!")
				return
			}

			var codeData: oauth_token
			do {
				codeData = try decoder.decode(
					oauth_token.self,
					from: response.data!
				)
			} catch {
				print(
					"LoginView loginGetToken: failed to decode response.data to oauth_token"
				)
				return
			}

			token = codeData.access_token
			print("token acquired! \(codeData.access_token)")

			getAccount()
		}
	}

	func loginGetCode() {
		if appsData == nil {
			print("LoginView loginGetCode: appsData is nil!")
			return
		}

		var authorizeUrl = "https://"
		authorizeUrl.append(domain)
		authorizeUrl.append("/oauth/authorize?client_id=")
		authorizeUrl.append(appsData!.client_id)
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
				print("LoginView loginRegisterApp: response.data is nil!")
				return
			}

			do {
				appsData = try decoder.decode(
					v1_apps.self,
					from: response.data!
				)
			} catch {
				print(
					"LoginView loginRegisterApp: failed to decode response.data to v1_apps"
				)
				return
			}

			client_id = appsData!.client_id
			client_secret = appsData!.client_secret

			loginGetCode()
		}
	}

	var body: some View {
		Group {
			Text("Lupine")
				.font(.title)
				.fontWeight(.bold)
				.padding()
		}
		.padding([.top, .leading, .trailing])

		Group {
			TextField("Instance domain", text: $domain)
				.padding([.top, .leading, .trailing])

			Button(action: {
				print("LoginView Go: \(domain)")
				loginRegisterApp()
			}) {
				Text("Go")
			}
			.padding(.horizontal)

			TextField("Code", text: $code)
				.padding(.horizontal)
			Button(action: {
				print("LoginView Finish")
				loginGetToken()
			}) {
				Text("Finish")
			}
			.padding([.leading, .bottom, .trailing])
		}
		.frame(width: 350.0, alignment: .bottomTrailing)
		.onAppear {
			openWindow(id: "Debug")
			isLoggedIn()
		}
	}
}

#Preview {
	LoginView()
}
