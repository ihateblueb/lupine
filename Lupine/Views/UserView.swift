//
//  UserView.swift
//  Lupine
//
//  Created by blueb on 2/25/25.
//

import SwiftUI

struct UserView: View {	
	@State public var userId: String

	var body: some View {
		Text("UserView(userId:\(userId)")
	}
}

#Preview {
	UserView(userId: "000000000")
}
