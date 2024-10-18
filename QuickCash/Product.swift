//
//  Product.swift
//  QuickCash
//
//  Created by Rajat Sachdeva on 2024-10-13.
//

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
        Product(id: "P001", name: "Coca-Cola", price: 2.49, quantity: 5),
        Product(id: "P002", name: "Doritos", price: 3.59, quantity: 10),
        Product(id: "P003", name: "Rasees", price: 1.39, quantity: 15),
        Product(id: "P004", name: "Skittles", price: 4.69, quantity: 7)
    ]
    
    func addProduct(_ product: Product) {
        self.products.append(product)
    }
    
    func deleteProduct(_ product: Product) {
        products.removeAll(where: { $0.id == product.id })
    }
}
