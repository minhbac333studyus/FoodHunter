//
//  DrinkDetailView.swift
//  res1.1
//
//  Created by AdamMacOS on 8/4/20.
//  Copyright © 2020 AdamMacOS. All rights reserved.
//

import SwiftUI
import Firebase
struct DrinkDetailView: View {
    @State var orderNum = 1
    var drink: DrinkModel
    
    var body: some View {
        
        
        ZStack(alignment:.topTrailing) {
            VStack(alignment: .leading, spacing:0) { 
                ImageDrinkDetailView(drink: drink)
                List {
                    TopDescription(drink: drink)
                }
                BottomOrderView(drink: drink, totalAmount: $orderNum)
            }
            OrderStepperButton(orderNumber: $orderNum).padding(.trailing, maxWidth/16)
                .padding(.top, maxHeight/3.7)
        }
            
        .edgesIgnoringSafeArea(.all)
        
    } 
}

struct DrinkDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetailView(drink: drinkData[2])
    }
}

struct TopDescription: View {
    var drink: DrinkModel
    var body: some View {
        
        DrinkDescriptionDetail(drink: drink).padding(.top, 50.0) 
            .listRowInsets( EdgeInsets())
            //Xoá khoang trắng 2 bên ảnh khi đc bỏ vào List
            .onAppear {
                UITableView.appearance().separatorStyle = .none
        }
        .onDisappear {
            UITableView.appearance().separatorStyle = .singleLine
        }
    }
}

struct DrinkDescriptionDetail: View {
    var drink: DrinkModel
    @State var showFullDescription = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12 ) {
            Text("\(drink.category.rawValue)".firstUppercased + " Drink")
                .font(Font.custom("Roboto-Thin", size: 18))
                .foregroundColor(Color.gray)
            HStack(alignment:.bottom,spacing: 22) {
                Image(systemName: "star.fill")
                    .frame(width:20, height: 25 , alignment: .leading)
                    .foregroundColor(Color.yellow)
                Text("4.9")
                    .font(.system(size: 18))
                    .foregroundColor(Color.gray)
            }
            
            HStack(alignment:.bottom,spacing: 22) {
                Image(systemName:  "flame.fill").resizable()
                    .frame(width:20, height: 25 , alignment: .leading)
                    .foregroundColor(Color.red) 
                Text(drink.calories + " kcal")
                    .font(.system(size: 18))
                    .foregroundColor(Color.gray)
            }
            Text("Description") 
                .font(Font.custom("Roboto-Black", size: maxWidth/19))
                .fontWeight(.bold)
            DescriptionToggleView(drink: drink, showFullDescription: self.$showFullDescription)
        }.padding(.horizontal)
    }
}



struct DrinkTitle: View {
    var drink: DrinkModel
    var body: some View {
        HStack(alignment: .top){
            VStack() {
                Text(drink.name).font(Font.custom("Palatino", size: 33))
                    .foregroundColor(.white)
            }
            .padding(.leading)
            //Spacer là kĩ thuật đẩy trong một hor/ver stack
            //Ở đây có thể xem như theo sau title là một khoảng trắng
            Spacer()
        }
    }
}

struct BackGoundForSubTitle: View {
    var body: some View {
        Rectangle().frame(height: 50).background(Color.black).opacity(0.5).blur(radius: 20)
    }
}

struct DrinkImage: View {
    var drink: DrinkModel
    var body: some View {
        
        Image(drink.imageName)
            .resizable().renderingMode(.original)
            //Chỉnh cách fill ảnh khít với khung hình
            .frame(width:maxWidth, height: maxHeight/3.5)
        
    }
}


struct BottomOrderView: View {
    var drink: DrinkModel
    @Binding var totalAmount :Int
    @State var CartPressed = false
    
    var body: some View {
        var TotalPri : Double {
            get {
                Double(totalAmount) * Double(drink.price)!
            }
        }
        return
            ZStack(alignment: .bottomLeading) {
                ZStack(alignment: .topTrailing ) {
                    OrderButtonBackGround()
                        .foregroundColor(Color(r: 145, g: 35, b: 45))
                        .frame(width:maxWidth ,height: maxHeight/8)
                    OrderNowButton(isPressed: $CartPressed, quantity: $totalAmount, drink: drink)
                        .padding(.trailing, maxWidth/16)
                    
                }
                HStack(spacing: maxWidth/34.5){
                    VStack(spacing:maxWidth/34.5){
                        Text("\(totalAmount)")
                        Text("Total Order")
                    }
                    VStack(spacing: maxWidth/34.5){
                        Text(perciseComma(TotalPri))
                        Text("Total Price")
                    }
                    
                }.font(.system( size: maxWidth/23))
                    .foregroundColor(Color.white)
                    .padding(.leading,maxWidth/30)
                    .padding(.bottom,maxHeight/80)
        }
    }
}



struct ImageDrinkDetailView: View {
    var drink : DrinkModel
    var body: some View {
        
        ZStack(alignment: .bottom) {
            DrinkImage(drink: drink)
            BackGoundForSubTitle()
            DrinkTitle(drink: drink)
        }
        //PriceDetailView(drink: drink).offset(y:55).scaleEffect(x: 0.8, y: 0.8)
        
    }
}
// PriceTag(drink: drink).offset(x:-15,y:10).scaleEffect(x: 1.2, y: 1.2)



///Nút Ỏrder sẽ có chức năng gửi đơn hàng của khách đến cơ sở dữ liệu 
struct OrderNowButton: View {
    @Binding var isPressed: Bool
    @Binding var quantity: Int
    //@Binding var subTotalPrice: Double
    var drink: DrinkModel
    var body: some View {
        var TotalPri : Double {
            get {
                Double(quantity) * Double(drink.price)!
            }
        }
      
        return Button(action: {
            
          //  let orderNumber = UInt32(Date().timeIntervalSince1970)
            //Gui items order vào database
            DispatchQueue.main.async {
                 sendTheDataModelToServer(To: currentCart,self.drink, TotalPri, self.quantity)
            }
          
            ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        })
        {
            ///design (Order Now)   Button
            ZStack(alignment: .center) {
                
                Image(systemName: "square.fill").resizable()
                    //.size(CGSize(width:120, height: 50))
                    .frame(width: maxWidth/5, height:maxWidth/5)
                    .foregroundColor(Color(r: 221, g: 173, b: 62) )
                    
                    
                    .padding(.bottom, 4.0)
                    .shadow(color: (self.isPressed ? Color.white: Color.gray), radius: 5, x: 4, y: 4)
                    .shadow(color: (self.isPressed ? Color.gray: Color.white), radius:4, x: -6, y: -4)
                    .scaleEffect(self.isPressed ? 0.8 : 1)
                    .animation(.spring())
                VStack {
                    Text("Order")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Text("Now")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                }.font(.system(size: maxWidth/22))
                
            }
        }
    }
}

