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
	@AppStorage("client_id") var client_id: String = ""
	@AppStorage("client_secret") var client_secret: String = ""
	@AppStorage("code") var code: String = ""
	@AppStorage("token") var token: String = ""

	@State private var domain: String = ""
	@State private var appsData: v1_apps? = nil

	func loginGetToken() {
		let decoder = JSONDecoder()

		if appsData == nil {
			print("LoginView loginGetToken: appsData is nil!")
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
			} catch { return }
			
			token = codeData.access_token
			print("token acquired! \(codeData.access_token)")
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
			} catch { return }
			
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
	}
}

#Preview {
	LoginView()
}
