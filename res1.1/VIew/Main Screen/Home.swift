//
//  ContentView.swift
//  res1.1
//
//  Created by AdamMacOS on 8/4/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI

struct Home: View {
    //Creat dictionary
    //(1/2)
    var body: some View {
         
		MainDisplay()
    }
}


struct MainDisplay: View {
    var categories:[String:[DrinkModel]]{
        .init(
            grouping: drinkData,
            by: {$0.category.rawValue}
        )
    }
	@EnvironmentObject var userLogin : UserModel
    var body: some View {
        NavigationView{
            TabView {
                List(categories.keys.sorted(), id: \.self){  key in
                    DrinkRowView(category: "\(key) Drinks".firstUppercased, drinkArray: self.categories[key]!)
                        .frame(height: 320)
                        .padding(.top)
                        .padding(.bottom)
                }
                .tabItem (
                    {
                        Image(systemName: "square.fill")
                        Text("Lily Pizza")
                    }
                ).hiddenNavigationBarStyle()
               
				Cart().tabItem { //Cart View

                    //cart Icon
                    Image(systemName: "cart.fill").resizable()
                    Text("Cart")
                }
				googleLoginView().tabItem{
					//cart Icon
					Image(systemName: "heart.fill").resizable()
					Text("User")
				}
            
            }
            .accentColor(Color.init(r: 113, g: 160, b: 65))
                /// Để navigation Hiden ở đây vì khi cần chuyển tab, nó sẽ tự động hide cho các tab còn lại
                /// Hiden cho TabView
            .hiddenNavigationBarStyle()
        }
    }
}
