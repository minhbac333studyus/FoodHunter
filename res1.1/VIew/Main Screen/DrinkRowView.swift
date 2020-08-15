//THis file will create a swipable row of drink menu

import SwiftUI

struct DrinkRowView: View {
    var category: String
    @State var drinkArray:[DrinkModel]
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(self.category)
                .font(Font.custom("Palatino", size: 30))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false)
            {
                HStack(alignment: .top, spacing: 15) {
                    ForEach(drinkArray, id: \.self, content: {drinkClosure in
                        NavigationLink(destination: DrinkDetailView(drink: drinkClosure)) {
                        DrinkItemView(drink:drinkClosure )}
                    })
                }
                .padding(.leading)
            }
        }
        
    }
}

struct DrinkRowView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkRowView(category: "HOT DRINK", drinkArray: drinkData)
    }
}
