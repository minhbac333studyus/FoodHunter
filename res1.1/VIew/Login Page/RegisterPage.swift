//
//  RegisterPage.swift
//  res1.1
//
//  Created by AdamMacOS on 8/13/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI
import Firebase

struct RegisterPage: View {
    
    @State var email = ""
    @State var pass = ""
	@State var rePass = ""
    @State var visible = false
	
	//verify the password
	@State var alert = false
	@State var error = ""
	
    var body: some View {
		ZStack(alignment: .center){
			VStack(alignment: .center, spacing: 20){
				Image("logo")
				///EMAIL TEXTFIELD
				emailTextField(email: $email)
				
				///PASS TEXTFIELD
				passwordTextField(visible: $visible, pass: $pass)
				
				///REPASS TEXTFIELD
				repeatPasswordTextField(visible: $visible, rePass: $rePass)
				
				///REGISTER BUTTON
				registerButton(email: $email, pass: $pass, rePass: $rePass, alert: $alert, error: $error)
			}
			.padding(.horizontal,25)
			.border(black)
			if self.alert {
				//Show error view in the middle of the screen @a
				ErrorView(alert: $alert, error: $error)
			}
		}
		
	}
}


struct repeatPasswordTextField : View{
	@Binding var visible : Bool
	@Binding var rePass: String
	
	var body: some View {
		///Repeat Password
		HStack {
			VStack{
				if self.visible{
					TextField("Repeat Password", text: self.$rePass)
				}
				else{
					SecureField("Repeat Password", text: self.$rePass)
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
		.stroke(self.rePass != "" ? Color(.red) : grayBlack, lineWidth: 2))
	}
}


struct registerButton : View {
	@Binding var email :String
	@Binding var pass: String
	@Binding var rePass: String
	@Binding var alert : Bool
	@Binding var error :String
	var body: some View {
		Button(action: {
			self.verifyRegister()
		} ) {
			Text("Register")
				.foregroundColor(.white)
				.frame(width: UIScreen.main.bounds.width - 100)
		}
		.padding(.vertical,10)
		.background(Color.blue)
		.cornerRadius(10)
		.padding(.top,30)
	}
	
	func verifyRegister() {
		if email != "" {
			if (pass == rePass) {
				Auth.auth().createUser(withEmail: email, password: pass) { (result, err) in
					if err != nil {
						//Gán giá trị false warning từ server
						self.error = err!.localizedDescription
						//CHo phép hiển thị bảng thông báo
						self.alert.toggle()
						return
					}
					print ("Create acount successfully")
					UserDefaults.standard.set(true,forKey: "status")
					NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
				}
			}
			else
			{
				self.error = "Password missmatch. Try again"
				self.alert.toggle()
			}
		}
		else{//Gán giá trị false warning từ iphone
			self.error = "Please fill all the blank."
			self.alert.toggle()
		}
	}
}

