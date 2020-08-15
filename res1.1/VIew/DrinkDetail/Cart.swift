
import SwiftUI
import Firebase
import GoogleSignIn
struct Cart: View {
    @State var isPressed = false
    @ObservedObject var cartdata = CartDataFromServer()
	//@Binding var user :UserModel
    //    @Binding var numberOfDrink :Int
    //    @Binding var price: Double
    //    @Binding var drink: DrinkModel
    var body: some View {
        VStack{
            List{
                ForEach( self.cartdata.CartArray ) { cartItem in
                    ///Item from server information
                    VStack(alignment: .leading, spacing: 10)
                    {
                        HStack(alignment: .top,spacing: 10){
                            Image("\(cartItem.ItemImage)").resizable()
                                .frame(width: 80, height: 50)
                                .cornerRadius(maxHeight / 100)
                                .background(Color.white)
                            VStack(alignment: .leading) {
                                Text("\(cartItem.ItemName)")
                                Text("\(perciseComma( cartItem.Price))")
                            }
                            .padding(.top,2.5)
                            
                            
                            ///remove an item in order -  button
                            Spacer()
                            Button(action:{
                                remove_Specific_Item_From_Server_Cart(remove_this: cartItem)
                            })
                            {
                                Image(systemName: "xmark")
                                    .padding(.top,2.5)
                            }
                        }
                        HStack(alignment: .bottom, spacing: 10, content: {
                            Image(systemName: "heart").frame(width: 80,height:30).border(black)
                            Text(" \(cartItem.Quantity)").frame(width: maxWidth - 200, height: 30).border(black)
                        })
                    }
                }
            }.onAppear() {
                self.cartdata.fetchData()
            }
            ConfirmPaymentButton(isPressed: $isPressed)
            
			NavigationLink(destination: LoginPage()) {
                LoginToPay_Apperance(isPressed: $isPressed)
            }
            //google()
        }
    } 
}



//Class này có chứa dữ liêu của cart -> dùng để hiển thị cho list các sản phẩm người dùng dẫ chọn
class  CartDataFromServer: ObservableObject{
    @Published var CartArray = [cartModel]()
    func fetchData(){
        let db = Firestore.firestore()
        db.collection("current cart").addSnapshotListener { (querySnapshot, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            guard let documents = querySnapshot?.documents else {
                print("Error fetching documents: \((err?.localizedDescription)!)")
                return
            }
            
            //Read each CartModel in Real-time QUeryDocument Snapshot
            self.CartArray = documents.map({ (QueryDocumentSnapshot) -> cartModel in
                let docInQuery = QueryDocumentSnapshot.data()
                
                let ImgNameDB = docInQuery["ItemImage"] as? String ?? ""
                let priceDB = docInQuery["Price"] as? Double ?? 0.0
                let quantityDB = docInQuery["Quantity"] as? Int ?? 0
                let idDB = docInQuery["Id"] as? Int ?? 0
                let nameDB = docInQuery["ItemName"] as? String ?? ""
                
                ///sau đó gán các dữ liệu lấy từ dataBase và ghép lại với cartModel variable
                ///Từ đó Cho ra một cartModel mới
                ///Hàm ko chạy forEach vì documents là số nhiều (bao gồm tất cả các sản phảm  đã được order )
                return cartModel(id: idDB , ItemImage: ImgNameDB , ItemName: nameDB , Quantity: quantityDB , Price: priceDB )
            })
        }
    }
}

struct ConfirmPaymentButton: View {
    @Binding var isPressed :Bool
    @ObservedObject var cartdata = CartDataFromServer()
    
    var body: some View {
        
        let orderNumber = String(UInt32(Date().timeIntervalSince1970))
        var tempArr = [cartModel]()
        return
            Button(action: {
                self.isPressed.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.isPressed = false
                }
                
                ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                let db = Firestore.firestore()
                let newDb = Firestore.firestore().collection(orderNumber)
                ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                db  .collection("current cart").getDocuments { ( snapshot, err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    }
                    guard let documents = snapshot?.documents else {
                        print("Error fetching documents: \((err?.localizedDescription)!)")
                        return
                    }
                    for eachDoc in documents {
                        let docInQuery = eachDoc.data()
                        newDb.addDocument(data: docInQuery)
                        let ImgNameDB = docInQuery["ItemImage"] as? String ?? ""
                        let priceDB = docInQuery["Price"] as? Double ?? 0.0
                        let quantityDB = docInQuery["Quantity"] as? Int ?? 0
                        let idDB = docInQuery["Id"] as? Int ?? 0
                        let nameDB = docInQuery["ItemName"] as? String ?? ""
                        tempArr.append(cartModel(id: idDB , ItemImage: ImgNameDB , ItemName: nameDB , Quantity: quantityDB , Price: priceDB ))
                    }
                }
                ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            })
            {
                ///design (Order Now)   Button
                confirmPaymentButton_Apperance(isPressed: $isPressed)
        }
    }
}

struct confirmPaymentButton_Apperance: View {
    @Binding var isPressed :Bool
    var body: some View {
        ZStack(alignment: .center) {
            
            Image(systemName: "square.fill").resizable()
                //.size(CGSize(width:120, height: 50))
                .frame(width: maxWidth/2, height:maxWidth/8)
                .foregroundColor(Color(r: 221, g: 173, b: 62) )
                
                
                .padding(.bottom, 4.0)
                .shadow(color: (self.isPressed ? Color.white: Color.gray), radius: 5, x: 4, y: 4)
                .shadow(color: (self.isPressed ? Color.gray: Color.white), radius:4, x: -6, y: -4)
                .scaleEffect(self.isPressed ? 0.8 : 1)
                .animation(.spring())
            VStack {
                Text("Confirm Payment")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
            }.font(.system(size: maxWidth/22))
            
        }
    }
}
struct LoginToPay_Apperance: View {
    @Binding var isPressed :Bool
    var body: some View {
        ZStack(alignment: .center) {
            
            Image(systemName: "square.fill").resizable()
                //.size(CGSize(width:120, height: 50))
                .frame(width: maxWidth/2, height:maxWidth/8)
                .foregroundColor(Color(r: 221, g: 173, b: 62) )
                
                
                .padding(.bottom, 4.0)
                .shadow(color: (self.isPressed ? Color.white: Color.gray), radius: 5, x: 4, y: 4)
                .shadow(color: (self.isPressed ? Color.gray: Color.white), radius:4, x: -6, y: -4)
                .scaleEffect(self.isPressed ? 0.8 : 1)
                .animation(.spring())
            VStack {
                Text("Login to pay")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                
            }.font(.system(size: maxWidth/22))
            
        }
    }
}

struct LoginToPayButton: View {
    @Binding var isPressed :Bool
    var body: some View {
        
        Button(action: {
            ///LOGIN TO GOOGLE HERE -----  function -----
        }){
            LoginToPay_Apperance(isPressed: $isPressed)
        }
    }
}

struct google : UIViewRepresentable {
    
    
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        
    }
}


