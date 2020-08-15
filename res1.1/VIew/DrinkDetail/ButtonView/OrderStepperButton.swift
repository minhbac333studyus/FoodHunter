//
//  OrderStepperButton.swift
//  res1.1
//
//  Created by AdamMacOS on 8/6/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI
func orderMoreThanOne(_ orderNumber:Int ) -> Bool {
    return orderNumber > 1
}

struct OrderStepperButton: View {
    @State private var isMinusPressed: Bool = false
    @State private var isPlusPressed: Bool = false
    @State var hasOrderNumber = false
    @Binding var orderNumber :Int
    let backgroundColor = Color(r: 225, g: 235, b: 251)
    
    //152 168 193
    let buttonColor = Color(r: 0, g: 0 , b: 0)
    var body: some View {
        
        ZStack {
            Image(systemName: "square.fill").resizable().frame(width: maxWidth/8, height: maxHeight/5).foregroundColor (Color.white)
                .shadow(color: Color.gray, radius: 8, x: 3, y: 3)
            VStack( spacing: 20) {
                Button(action: {
                    self.orderNumber += 1
                    self.isPlusPressed.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        self.isPlusPressed = false
                    }
                })
                {
                    Image(systemName: "plus.circle")
                        .font(Font.system(size: maxWidth/12))
                

                }
                .foregroundColor(self.isPlusPressed ? Color.white: buttonColor)
                .shadow(color: (self.isPlusPressed ? Color.white: Color.gray), radius: (self.isPlusPressed ? 10 : 5 ), x: 5, y: 4).opacity(0.8)
                .shadow(color: (self.isPlusPressed ? Color.gray: Color.white), radius:4, x: -6, y: -4)
                .scaleEffect(self.isPlusPressed ? 0.8 : 1)
                .animation(.spring())
                
         
                
                VStack(alignment:.trailing) {
                    ZStack {
                            Image(systemName: "circle")
                                .font(Font.system(size: maxWidth/12))
                        Text("\(orderNumber)").foregroundColor(Color.black)
                    }
                }
                 
                
                Button(action: {
                    if (orderMoreThanOne(self.orderNumber)){
                        self.orderNumber -= 1
                        self.isMinusPressed.toggle()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                            self.isMinusPressed = false
                        }
                    }
                })
                {
                    Image(systemName: "minus.circle")
                        .font(Font.system(size: maxWidth/12))
                }
               
                .foregroundColor(self.isMinusPressed ? Color.white: buttonColor)
                .shadow(color: (self.isMinusPressed ? Color.white: Color.gray), radius: (self.isMinusPressed ? 10 : 5 ), x: 5, y: 4).opacity(0.8)
                .shadow(color: (self.isMinusPressed ? Color.gray: Color.white), radius:4, x: -6, y: -4)
                .scaleEffect(self.isMinusPressed ? 0.8 : 1) 
                .padding(.bottom, 4.0)
                .animation(.spring())
            }
        }
    }
}



struct OrderStepperButton_Previews: PreviewProvider {
    static var previews: some View {
        OrderStepperButton(orderNumber: .constant(1))
    }
}
