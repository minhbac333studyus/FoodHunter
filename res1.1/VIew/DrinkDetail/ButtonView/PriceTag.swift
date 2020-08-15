//
//  PriceTag.swift
//  res1.1
//
//  Created by AdamMacOS on 8/7/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct PriceTag: View {
    var drink:DrinkModel
    var body: some View {
        Text("$" + drink.price).font(.headline).fontWeight(.bold)
            .frame(width: 60, height: 30)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
struct PriceTag_Previews: PreviewProvider {
    static var previews: some View {
        PriceTag(drink: drinkData[0])
    }
}
