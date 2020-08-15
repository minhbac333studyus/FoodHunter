//
//  KvalueLibrary.swift
//  res1.1
//
//  Created by AdamMacOS on 8/8/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
//Screen resolution
let maxHeight = UIScreen.main.bounds.height
let maxWidth = UIScreen.main.bounds.width

 /////////// COLOR PALETT
let black = Color.black
let grayBlack  = Color.black.opacity(0.7 )
///////////////////////////////////////////
//Menu
let currentCart:String = "current cart"
var data = ["Cart"]//"Home",,"Wishlist","Saved Cards","Settings","Help"]
let backgroundColor = Color(r: 225, g: 235, b: 251).opacity(0.5)

func perciseComma( _ numberDouble: Double) -> String{
    let stringValue = String(format: "$ %.2f", numberDouble)
    return stringValue
}

extension Color {
    init (r:Double,g:Double,b:Double) {
        
        self.init(red: (r/255), green: (g/255), blue: (b/255))
    }
}
extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

//////////HIDE NAVIGATION BẢ TRICK
struct HiddenNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

extension View {
    func hiddenNavigationBarStyle() -> some View {
        modifier( HiddenNavigationBar() )
    }
}
