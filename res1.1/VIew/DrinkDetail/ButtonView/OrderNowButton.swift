//
//  addToCartButton.swift
//  res1.1
//
//  Created by AdamMacOS on 8/7/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI
import Firebase
struct OrderNowButton: View {
    @Binding var isPressed: Bool
    
    var body: some View {
        Button(action: {
            self.isPressed.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.isPressed = false
            }
            
            //Gui choice order vao database
            let db = Firestore.firestore()
            db.collection("cart").document()
            .setDa
        })
            
            
            
            
            
            
        {
            ZStack(alignment: .center) {
                
                Image(systemName: "square.fill").resizable()
                    //.size(CGSize(width:120, height: 50))
                    .frame(width: maxWidth/5, height:maxWidth/5)
                    .foregroundColor(Color(r: 221, g: 173, b: 62) )
                
               
                .padding(.bottom, 4.0)
                .shadow(color: (self.isPressed ? Color.white: Color.gray), radius: 5, x: 4, y: 4)
                .shadow(color: (self.isPressed ? Color.gray: Color.white), radius:4, x: -6, y: -4)
                 .scaleEffect(self.isPressed ? 0.8 : 1)
                .animation(.spring())
                VStack {
                    Text("Order")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text("Now")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                }.font(.system(size: maxWidth/22))
                
            }
        }  
    }
}

struct addToCartButton_Previews: PreviewProvider {
    static var previews: some View {
        OrderNowButton(isPressed: .constant(false))
    }
}

