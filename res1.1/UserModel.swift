//
//  UserModel.swift
//  res1.1
//
//  Created by AdamMacOS on 8/14/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import Foundation
import Firebase
class UserModel : ObservableObject{
	 
	@Published var userEmail :String
	@Published var tokenIsActive : Bool
	init() {
		userEmail = ""
		tokenIsActive = false
	}
}
