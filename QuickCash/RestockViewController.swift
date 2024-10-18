//
//  RestockViewController.swift
//  QuickCash
//
//  Created by Rajat Sachdeva on 2024-10-14.
//

import UIKit

class RestockViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var quantityOutlet: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedProduct: Product?
    
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductManager.shared.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ProductManager.shared.products[indexPath.row].name
        cell.detailTextLabel?.text = String(ProductManager.shared.products[indexPath.row].quantity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = ProductManager.shared.products[indexPath.row]
        
        selectedRow = indexPath.row
    }
    
    
    @IBAction func restockAction(_ sender: Any) {
        if let selectedRow, let quantity = Int(quantityOutlet.text!) {
            ProductManager.shared.products[selectedRow].quantity = quantity
            let alert = UIAlertController(title: "Updated Successfully", message: "Product quantity updated successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            tableView.reloadData()
        } else if selectedRow == nil {
            let alert = UIAlertController(title: "Error", message: "Please select a product", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a valid quantity", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
