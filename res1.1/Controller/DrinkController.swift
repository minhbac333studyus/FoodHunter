//
//  Data.swift
//  CoffeeDBApp
//
//  Created by Brian Advent on 23.06.19.
//  Copyright © 2019 Brian Advent. All rights reserved.
//

import Foundation
import Firebase

let drinkData:[DrinkModel] = load("drinks.json")

func load<T:Decodable>(_ filename:String, as type:T.Type = T.self) -> T {
    let data:Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

 

//cập nhập số lượng loai sản phẩm hiện tai lên giỏ đồ tạm thời trển server
func sendTheDataModelToServer(To collection: String,_ drink: DrinkModel, _ TotalPri: Double, _ quantity: Int ) {
    let db = Firestore.firestore()
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    db  .collection(collection)
        .document(String( drink.id) )//cái này sẽ tự động update tất cả các đơn hàng, Tất cả các item cùng tên nếu bấm nhiều lần sẽ cập nhập cái cuối cùng
        .setData(["Id": drink.id ,"ItemImage": drink.imageName, "Quantity": quantity, "Price": TotalPri, "ItemName": drink.name]){ (err) in
            if err !=  nil {
                print((err?.localizedDescription)!)
                return
            }
            print("Upload item to temporary cart sever successfully")
    }
}

///Gửi giỏ đồ hiện tại của user lên sever
func sendTheDataModelToServer(To collection: String,_ cart: cartModel, _ TotalPri: Double, _ quantity: Int ) {
    let db = Firestore.firestore()
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    db  .collection(collection)
        .document("\( cart.ItemName)")//cái này sẽ tự động update tất cả các đơn hàng, Tất cả các item cùng tên nếu bấm nhiều lần sẽ cập nhập cái cuối cùng
        .setData(["Id": cart.id ,"ItemImage": cart.ItemImage, "Quantity": quantity, "Price": TotalPri, "ItemName": cart.ItemName]){ (err) in
            if err !=  nil {
                print((err?.localizedDescription)!)
                return
            }
            print("Upload item to temporary cart sever successfully")
    }
}

///Hàm dành cho nut remove trong giỏ đồ, hoạt động khi user muốn xoá một sản phẩm ra khỏi đơn hàng
func remove_Specific_Item_From_Server_Cart(remove_this itemNeedRemove: cartModel) {
    let db = Firestore.firestore()
    db.collection("current cart").document(String(itemNeedRemove.id)).delete(){ err in
        if let errorr  = err {
            print("Error removing document: \(errorr)")
            return
        }
        print("Document successfully removed!")
        
        
    }
}


func rm_doc_in_curCart_From_Server_cart(remove docNeedRemove:String ){
    let db = Firestore.firestore()
    db.collection("current cart").document(docNeedRemove).delete() { err in
        if let err = err {
            print("Error removing document: \(err)")
        } else {
            print("Document \(docNeedRemove) successfully removed!")
        }
    }
}
func rm_subDoc_in_curCart_From_Server_cart(To subDocNeedRemove:String, remove subFieldNeedRemove:String ){
    let db = Firestore.firestore()
    db.collection("current cart").document(subDocNeedRemove).updateData([
        subFieldNeedRemove: FieldValue.delete(),
    ]) { err in
        if let err = err {
            print("Error updating document: \(err)")
        } else {
            print("Field \(subFieldNeedRemove) successfully updated")
        }
    }
}
