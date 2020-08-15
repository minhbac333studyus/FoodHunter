//
//  DescriptionToggleView.swift
//  res1.1
//
//  Created by AdamMacOS on 8/7/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct DescriptionToggleView: View {
    var drink : DrinkModel
    @Binding var showFullDescription :Bool
    var body: some View {
        Button(action: {
            self.showFullDescription.toggle()
        } ){
            
            if (showFullDescription)
            {
                Text(String(drink.description))
                    .foregroundColor(Color.black  )
                     .font(Font.custom("Roboto-Thin", size: maxWidth/25.875))
                  
                    .multilineTextAlignment(.leading)
                    .lineSpacing(8)
                   
            }else
            {
                Text(String(drink.description))
                    .foregroundColor(Color.black  )
                     .font(Font.custom("Roboto-Thin", size: maxWidth/25.875))
                    .multilineTextAlignment(.leading)
                    .lineSpacing(4)
                     .lineLimit(4)
            }
        }
    }
}

struct DescriptionToggleView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionToggleView(drink: drinkData[0], showFullDescription: .constant(true))
    }
}
