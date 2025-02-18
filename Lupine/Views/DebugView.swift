//
//  DebugView.swift
//  Lupine
//
//  Created by blueb on 2/18/25.
//

import SwiftUI

struct DebugView: View {
	@AppStorage("domain") var domain: String = ""
	@AppStorage("client_id") var client_id: String?
	@AppStorage("client_secret") var client_secret: String?
	@AppStorage("code") var code: String = ""
	@AppStorage("token") var token: String?

	@AppStorage("account") var account: v1_user? = nil

	var body: some View {
		Group {
			VStack {
				Text("@AppStorage(\"domain\")")
				Text("\(String(describing: domain))")
			}

			VStack {
				Text("@AppStorage(\"client_id\")")
				Text("\(String(describing: client_id))")
			}

			VStack {
				Text("@AppStorage(\"client_secret\")")
				Text("\(String(describing: client_secret))")
			}

			VStack {
				Text("@AppStorage(\"code\")")
				Text("\(String(describing: code))")
			}

			VStack {
				Text("@AppStorage(\"token\")")
				Text("\(String(describing: token))")
			}

			VStack {
				Text("@AppStorage(\"account\")")
				Text("\(String(describing: account))")
			}
		}.padding(.all, 5.0)
	}
}

#Preview {
	DebugView()
}
