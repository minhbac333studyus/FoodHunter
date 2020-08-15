//
//  ErrorView.swift
//  res1.1
//
//  Created by AdamMacOS on 8/14/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI


struct ErrorView : View {
	
	
	@Binding var alert : Bool
	@Binding var error : String
	
	var body: some View{
		VStack{
			
			HStack{
				///Nếu user yêu cầu reset thì hiển thị thông tin, nếu ko thì hiển thị các lỗi do người dùng nhập sai
				Text(self.error == "RESET" ? "Message" : "Error")
					.font(.title)
					.fontWeight(.bold)
					.foregroundColor(grayBlack)
				
				Spacer()
			}
			.padding(.horizontal, 25)
			
			Text(self.error == "RESET" ? "Password reset link has been sent successfully" : self.error)
				.foregroundColor(grayBlack)
				.padding(.top)
				.padding(.horizontal, 25)
			
			Button(action: {
				self.alert.toggle()
			}) {
				Text(self.error == "RESET" ? "Ok" : "Cancel")
					.foregroundColor(.white)
					.padding(.vertical)
					.frame(width: UIScreen.main.bounds.width - 120)
			}
			.background(Color("redUniversal"))
			.cornerRadius(10)
			.padding(.top, 25)
		}
		.padding(.vertical, 25)
		.frame(width: UIScreen.main.bounds.width - 70)
		.background(Color.white)
		.cornerRadius(15)
	}
}
