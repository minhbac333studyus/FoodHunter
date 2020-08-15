import SwiftUI

//Khi tạo một hàng hiển thi các loại drinks, Hàm ForEach yêu cầu DrinkModel Hashable
struct DrinkModel: Codable,Hashable ,Identifiable{
    var id:Int
    var name:String
    var imageName:String
    var category:Category
    var description:String
    var price: String
    var calories: String
    enum Category: String, Codable,Hashable,CaseIterable{
        case hot = "hot"
        case cold = "cold"
    }
    
}
