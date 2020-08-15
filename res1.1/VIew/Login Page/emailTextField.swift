//
//  emailTextField.swift
//  res1.1
//
//  Created by AdamMacOS on 8/14/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct emailTextField : View {
	@Binding var email : String
	var body : some View {
		TextField("Enter your email", text: self.$email)
			.padding()
			.background(RoundedRectangle(cornerRadius: 4)
				.stroke(self.email != "" ? Color(.red) : grayBlack, lineWidth: 2))
	}
}
