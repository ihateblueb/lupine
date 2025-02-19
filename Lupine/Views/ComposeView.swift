//
//  ComposeView.swift
//  Lupine
//
//  Created by blueb on 2/19/25.
//

import SwiftUI

struct ComposeView: View {
	@Environment(\.dismissWindow) var dismissWindow
	
	@AppStorage("domain") var domain: String = ""
	
	@AppStorage("draft_text") var draft_text: String = ""
	@AppStorage("draft_spoiler_text") var draft_spoiler_text: String = ""
	@AppStorage("draft_visibility") var draft_visibility: String = "public"
	
	@State var showErrorAlert = false
	@State private var returnedStatus: v1_status? = nil

	func sendPost() {
		let decoder = JSONDecoder()
		
		struct PostBody: Encodable {
			public var status = ""
			public var spoiler_text = ""
			public var visibility = ""

			init(text: String, spoiler_text: String, visibility: String) {
				self.status = text
				self.spoiler_text = spoiler_text
				self.visibility = visibility
			}
		}
		
		HttpClient().post(
			url: "https://\(domain)/api/v1/statuses",
			body: PostBody(
				text: draft_text,
				spoiler_text: draft_spoiler_text,
				visibility: draft_visibility
			),
			authenticate: true
		).response { response in
			if response.data == nil {
				print("ComposeView sendPost: response.data is nil!")
				showErrorAlert = true;
				return
			}
			
			do {
				returnedStatus = try decoder.decode(
					v1_status.self,
					from: response.data!
				)
			} catch {
				print(
					"ComposeView sendPost: failed to decode response.data to v1_status"
				)
				showErrorAlert = true;
				return
			}
			
			draft_text = ""
			draft_spoiler_text = ""
			draft_visibility = "public"
			
			dismissWindow()
		}
	}

	var body: some View {
		VStack(alignment: .trailing) {
			TextField("Content warning", text: $draft_spoiler_text)
				.textFieldStyle(.roundedBorder)
			TextEditor(text: $draft_text)
				.background(Color.primary.colorInvert())
				.cornerRadius(5)
				.overlay(
					RoundedRectangle(cornerRadius: 5)
						.stroke(.black, lineWidth: 1 / 3)
						.opacity(0.3)
				)
				.font(.system(size: 13))

			Button(action: {
				sendPost()
			}) {
				Text("Post")
			}.buttonStyle(.borderedProminent)
		}
		.frame(alignment: .bottomTrailing)
		.padding( /*@START_MENU_TOKEN@*/.all /*@END_MENU_TOKEN@*/)
		.alert("Something went wrong.", isPresented: $showErrorAlert) {
			Button("OK", role: .cancel) { }
		}
	}
}

#Preview {
	ComposeView()
}
