//
//  googleLoginView.swift
//  res1.1
//
//  Created by AdamMacOS on 8/13/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct googleLoginView: View {
	@EnvironmentObject var userData : UserModel
    var body: some View {
		VStack{
			Text(String(userData.tokenIsActive))
			Text("\(userData.userEmail)")
		}
		
    }
}


