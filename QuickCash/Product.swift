import Foundation

class Product {
    
    var id: String = ""
    var name: String = ""
    var price: Double = 0
    var quantity: Int = 0
    
    init(id: String, name: String, price: Double, quantity: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

class ProductManager {
    
    public static var shared: ProductManager = .init()
    
    var products: [Product] = [
        Product(id: "P001", name: "Pants", price: 40.99, quantity: 30),
        Product(id: "P002", name: "Shoes", price: 50.23, quantity: 45),
        Product(id: "P003", name: "Tshirts", price: 15.45, quantity: 38),
        Product(id: "P004", name: "Dresses", price: 30.99, quantity: 67)
    ]
    
    func addProduct(_ product: Product) {
        self.products.append(product)
    }
    
    func deleteProduct(_ product: Product) {
        products.removeAll(where: { $0.id == product.id })
    }
}
