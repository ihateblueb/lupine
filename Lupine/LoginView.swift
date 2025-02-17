//
//  LoginView.swift
//  Lupine
//
//  Created by blueb on 2/17/25.
//

import SwiftUI
import SwiftData

struct LoginView: View {
	@Environment(\.modelContext) private var modelContext

	@State private var domain: String = ""
	
	func attemptLogin() {
		HttpClient().post(url: "https://\(domain)/api/v1/apps")
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
