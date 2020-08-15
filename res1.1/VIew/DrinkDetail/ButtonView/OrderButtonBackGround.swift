//
//  check.swift
//  res1.1
//
//  Created by AdamMacOS on 8/7/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct OrderButtonBackGround: View {
    var body: some View {
        CustomShape()
    }
}

struct OrderButtonBackGround_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            //Text("\(maxWidth)")
            OrderButtonBackGround()
                . frame(width: maxWidth,height: maxHeight/8)
                .border(Color.green)
                .foregroundColor (Color.red)
        }
    }
}
struct CustomShape : Shape {
    
    func path(in rect: CGRect) -> Path {
        
        return Path{path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: maxHeight/16))
            path.addLine(to: CGPoint(x: rect.width, y: maxHeight/8))
            path.addLine(to: CGPoint(x: 0, y: maxHeight/8))
            
        }
    }
}
