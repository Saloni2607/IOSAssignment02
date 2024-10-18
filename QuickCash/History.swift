//
//  History.swift
//  QuickCash
//
//  Created by Rajat Sachdeva on 2024-10-14.
//

import Foundation

class History {
    
    var date: Date
    var product: String = ""
    var quantity: String = ""
    var total: Double = 0
    
    init(date: Date, product: String, quantity: String, total: Double) {
        self.date = date
        self.product = product
        self.quantity = quantity
        self.total = total
    }
}

class HistoryManager {
    
    public static var shared: HistoryManager = .init()
    
    var history: [History] = []
    
    func addHistory(_ history: History) {
        self.history.append(history)
    }
}
