//
//  SubOptionViewToggle.swift
//  res1.1
//
//  Created by AdamMacOS on 8/6/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct SubOptionViewToggle: View {
    @Binding var isShowPressed : Bool
    @State var optionTapped = "Home"
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12){
                
                //Spacer()
                HStack(spacing: 15) {
                    Image("pic").resizable()
                        .frame(width: 80, height: 80)
                    VStack (alignment: .leading, spacing: 8){
                        Text("User: AdamCat")
                            .fontWeight(.medium)
                        Text("San Angelo, Texas")
                            .fontWeight(.medium)
                    }
                }.padding(.bottom, 50)
        
                ForEach(data, id: \.self) { subChoice in
                    Button(action: {
                        self.optionTapped = subChoice
                    }) {
                        HStack{
                            Capsule().fill(self.optionTapped == subChoice ? Color.orange : Color.clear)
                                .frame(width: 5, height: 20)
                            Text("\(subChoice)").padding(.leading)
                            .foregroundColor(.black)
                        }.padding(.vertical)
                    }                }
                ToggleBackButton(show: self.$isShowPressed).padding(.leading)
                Spacer()
            }
            .padding(.leading)
            .padding(.top)
            Spacer()
        }
    }
}


struct SubOptionViewToggle_Previews: PreviewProvider {
    static var previews: some View {
        SubOptionViewToggle(isShowPressed: .constant(true))
    }
}
