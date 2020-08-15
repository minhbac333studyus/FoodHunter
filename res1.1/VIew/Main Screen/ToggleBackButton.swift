//
//  ToggleBackButton.swift
//  res1.1
//
//  Created by AdamMacOS on 8/5/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct ToggleBackButton: View {
    @Binding var show: Bool
    var body: some View {
        HStack {
            
            Button(action: {
                
                withAnimation(.spring()){
                    self.show.toggle()
                }
                
            }) {
                
                Image(systemName: "xmark")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
                
            }.padding()
                .opacity(self.show ? 1 : 0)
           
        }
    }
}

struct ToggleBackButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleBackButton(show: .constant(true))
    }
}
