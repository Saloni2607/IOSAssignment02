//
//  CashViewController.swift
//  QuickCash
//
//  Created by Rajat Sachdeva on 2024-10-14.
//

import UIKit

class CashViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var productLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedProduct: Product?
    
    var selectedRow: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductManager.shared.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ProductManager.shared.products[indexPath.row].name + " - $\(ProductManager.shared.products[indexPath.row].price)"
        cell.detailTextLabel?.text = String(ProductManager.shared.products[indexPath.row].quantity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = ProductManager.shared.products[indexPath.row]
        
        selectedRow = indexPath.row
        
        productLabel.text = selectedProduct?.name
        
        if (Int(quantityLabel.text!)! > 0) {
            let total = selectedProduct!.price * Double(quantityLabel.text!)!
            totalLabel.text = String(format: "%.2f", total)
        }
    }
    
    @IBAction func keypadAction(_ sender: Any) {
        let keypad = sender as! UIButton
        let num = Int((keypad.titleLabel?.text)!)
        quantityLabel.text! = String(Int(quantityLabel.text!)! * 10 + num!)
        
        if ((selectedProduct) != nil) {
            let total = selectedProduct!.price * Double(quantityLabel.text!)!
            totalLabel.text = String(format: "%.2f", total)
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
        quantityLabel.text! = "0"
        totalLabel.text! = "0.0"
        productLabel.text! = ""
        selectedProduct = nil
        tableView.reloadData()
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        quantityLabel.text! = String(Int(quantityLabel.text!)! / 10)
        
        if (Int(quantityLabel.text!)! > 0) {
            let total = selectedProduct!.price * Double(quantityLabel.text!)!
            totalLabel.text = String(format: "%.2f", total)
        }
    }
    
    @IBAction func buyAction(_ sender: Any) {
        if let selectedProduct = selectedProduct, let quantity = quantityLabel.text, let total = Double(totalLabel.text!) {
            if Int(quantity)! > selectedProduct.quantity {
                let alert = UIAlertController(title: "Insufficient Stock", message: "The selected quantity for \(selectedProduct.name) exceeds the available stock of \(selectedProduct.quantity)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                ProductManager.shared.products[selectedRow!].quantity -= Int(quantity)!
                let newHistory = History(date: Date(), product: selectedProduct.name, quantity: quantity, total: total)
                HistoryManager.shared.addHistory(newHistory)
                
                let alert = UIAlertController(title: "Payment Successful", message: "This order has been process successfully", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                clearAction(self)
            }
        }
    }
}
