//
//  SubOptionView.swift
//  res1.1
//
//  Created by AdamMacOS on 8/5/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI
struct SubOptionView: View {
   // @Binding var showButtonPressed :Bool
    @State var optionTapped = "Home"
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
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
                }
                
            }
            Spacer()
            /*
            HStack {
                Spacer()
                Button(action: {
                    self.showButtonPressed.toggle()
                }) {
                    Image(systemName: "xmark").resizable().frame(width: 20, height: 20).foregroundColor(.black)
                }
                
                Spacer()
            }
 */
           
        }
        .padding(.leading)
        .padding(.top)
    }
}
var data = ["Home","Orders","Wishlist","Saved Cards","Settings","Help"]

struct SubOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubOptionView()//showButtonPressed: .constant(true))
    }
}
