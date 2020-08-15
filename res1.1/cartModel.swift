import Foundation
 
///ta có thể gưi dữ liệu đi và thu dữ liệu về , thông qua model này
struct cartModel:Codable,Hashable,  Identifiable{
    var id : Int
    var ItemImage: String
    var ItemName: String
    var Quantity: Int
    var  Price: Double
}
