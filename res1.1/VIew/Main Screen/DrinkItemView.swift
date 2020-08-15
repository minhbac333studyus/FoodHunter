//
//  DrinkItemVIew.swift
//  res1.1
//
//  Created by AdamMacOS on 8/4/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct DrinkItemView: View {
    @State var drink:DrinkModel
    var body: some View {
        //Spacing là khoảng cách cuả ảnh tới tên đồ uống
        VStack(alignment: .leading, spacing: 5.0) {
            ImageDrink(drink: $drink).animation(.spring())
            TitleAndPrice(drink: $drink)
            Description(drink: $drink)
        }
    }
}

struct DrinkItemVIew_Previews: PreviewProvider {
    static var previews: some View {
        DrinkItemView(drink: drinkData[0])
    }
}

struct ImageDrink: View {
    @Binding var drink:DrinkModel
    var body: some View {
        Image(drink.imageName)
            .resizable().renderingMode(.original)
            //Chỉnh cách fill ảnh khít với khung hình
            .aspectRatio(contentMode: .fill)
            //Chỉnh bộ khung của ảnh
            .frame(width: maxWidth/1.8, height:maxHeight/5, alignment: .leading)
            //Chỉnh viền cong
            .cornerRadius(30)
        
    }
}

struct TitleAndPrice: View {
    @Binding var drink:DrinkModel
    var body: some View {
        HStack() {
            Text(drink.name)
                .font(Font.custom("Palatino", size: 20))
                .multilineTextAlignment(.leading)
                
                .foregroundColor(Color.black)
            Spacer()
            PriceTag(drink: drink)
             
               
        }
    .frame(width: maxWidth/1.8)
        
    }
}

struct Description: View {
    @Binding var drink:DrinkModel
    var body: some View {
        Text(drink.description)
             .font(Font.custom("Roboto-Thin", size: maxWidth/26))
            .multilineTextAlignment(.leading)
          
            .lineLimit(2)
            .frame(width: maxWidth/1.8, height: 40, alignment: .leading)
            .foregroundColor(Color.black)
    }
}


