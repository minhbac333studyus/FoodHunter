//
//  PriceForDetailDrinkView.swift
//  res1.1
//
//  Created by AdamMacOS on 8/6/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI



struct PriceDetailView: View {
    var drink:DrinkModel
    var body: some View {
        
        ZStack(alignment: .center) {
            
            Image(systemName:"tag.fill").resizable().foregroundColor(.red)
                .rotationEffect(.degrees(-45))
                .frame(width: 90, height:90)
            Text( drink.price) .fontWeight(.heavy).foregroundColor(.white).font(.system(size: 25)).offset(x:8)
        }
    }
}

struct PriceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PriceDetailView(drink: drinkData[3])
    }
}
