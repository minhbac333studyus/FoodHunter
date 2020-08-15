//
//  passwordTextField.swift
//  res1.1
//
//  Created by AdamMacOS on 8/14/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct passwordTextField:View {
	@Binding var visible : Bool
	@Binding var pass: String
	var body: some View {
		HStack {
			VStack{
				if self.visible{
					TextField("Password", text: self.$pass)
				}
				else{
					SecureField("Password", text: self.$pass)
				}
			}
			Button (action: {
				self.visible.toggle()
			}) {
				self.visible ? Image(systemName: "eye.fill") : Image(systemName: "eye.slash.fill")
			}
			
		}
		.padding()
		.background(RoundedRectangle(cornerRadius: 4)
		.stroke(self.pass != "" ? Color(.red) : grayBlack, lineWidth: 2))
	}
}
