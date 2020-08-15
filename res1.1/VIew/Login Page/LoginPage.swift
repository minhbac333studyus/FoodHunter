//
//  LoginPage.swift
//  res1.1
//
//  Created by AdamMacOS on 8/13/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//


import SwiftUI
import Firebase

struct LoginPage: View {
    @State var color  = Color.black.opacity(0.7 )
    @State var email = ""
    @State var pass = ""
    @State var visible = false
    @State var show = false
	@EnvironmentObject var user : UserModel
	//verify the password
	@State var alert = false
	@State var error = ""
    var body: some View {
        
		ZStack {
			VStack(alignment: .trailing){
             NavigationLink(destination: RegisterPage()){
                Text("Register")
                .fontWeight(.bold)
                .foregroundColor(Color("redUniversal"))
                .padding()
            }

            ///LOGIN MAIN PAGE--------------------------------------------
            VStack(alignment: .center, spacing: 20){
                Image("logo")
                ///EMAIL TEXTFIELD
                emailTextField(email: $email)
				
                ///PASS TEXTFIELD
                passwordTextField(visible: $visible, pass: $pass)
                
				///FORGOT PASSWORD
                forgotPasswordButton()
                
                ///REGISTER BUTTON
                Button(action: {
					self.verify()
                } ) {
                    Text("Login")
                        .foregroundColor(.white)
                        
                        .frame(width: UIScreen.main.bounds.width - 100)
                    
                }
                .padding(.vertical,10)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.top,30)
                
            }
				.padding(.horizontal,25)
			Spacer()
			///LOGIN MAIN PAGE------------------------------------------------
			
		}
			if self.alert {
				//Show error view in the middle of the screen @a
				ErrorView(alert: $alert, error: $error)
			}
		}
    } ////END OF BODY VIEW
	
	func reset(){
		
		if self.email != ""{
			
			Auth.auth().sendPasswordReset(withEmail: self.email) { (err) in
				
				if err != nil{
					
					self.error = err!.localizedDescription
					self.alert.toggle()
					return
				}
				
				self.error = "RESET"
				self.alert.toggle()
			}
		}
		else{
			
			self.error = "Email Id is empty"
			self.alert.toggle()
		}
	}
	
	func verify(){
		
		if self.email != "" && self.pass != ""{
			Auth.auth().signIn(withEmail: self.email, password: self.pass) { (res, err) in
				
				if err != nil{
					
					self.error = err!.localizedDescription
					self.alert.toggle()
					return
				}
				
				print("success login and also set data to the phone")
				UserDefaults.standard.set(true, forKey: "status")
				NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
				self.user.tokenIsActive = true
				
				Auth.auth().addStateDidChangeListener { (auth, user) in
				self.user.userEmail = user?.email ?? "Unknown User"
				print(user?.email)
				}
			}
		} else{
			self.error = "Please fill all the contents properly"
			self.alert.toggle()
		}
	}//end of verify function
}

struct forgotPasswordButton : View{
	var body: some View {
		///FORGOT PASSWORD
		HStack{
			Spacer()
			Button(action: {
				
			})
			{
				Text("Forget password ?")
					.fontWeight(.bold)
					.foregroundColor(.black)
			}
		}
	}
}
