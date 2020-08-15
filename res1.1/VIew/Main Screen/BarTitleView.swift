//
//  BarTitleView.swift
//  res1.1
//
//  Created by AdamMacOS on 8/6/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI
struct BarTitleView:  View {
    @Binding var menuButtonPressed :Bool
    var body: some View {
        VStack(alignment: .center,spacing: 5) {
            Text("LILY PIZZA")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            HStack {
                Button(action: {
                    self.menuButtonPressed.toggle()
                }) {
                    Image("Menu").resizable()
                        .renderingMode(.original)
                        .frame(width: 30, height: 25)
                }.padding(.leading, 30)
                Spacer()
            } 
        }
        
    }
}

struct BarTitleView_Previews: PreviewProvider {
    static var previews: some View {
        BarTitleView(menuButtonPressed: .constant(true))
    }
}
