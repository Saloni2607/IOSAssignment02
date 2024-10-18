//
//  HistoryDetailsViewController.swift
//  QuickCash
//
//  Created by Rajat Sachdeva on 2024-10-14.
//

import UIKit

class HistoryDetailsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var selectedIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = HistoryManager.shared.history[selectedIndex].product
        quantityLabel.text = "Quantity: " + HistoryManager.shared.history[selectedIndex].quantity
        totalLabel.text = "Total: " + String(HistoryManager.shared.history[selectedIndex].total)
        
        let date =  HistoryManager.shared.history[selectedIndex].date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: date)
        dateLabel.text = "Date: " + dateString
    }

}
