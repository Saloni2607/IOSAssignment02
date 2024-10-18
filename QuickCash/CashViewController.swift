import UIKit

// Main view controller for handling cash register operations
class CashViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets for UI components
    @IBOutlet weak var quantityLabel: UILabel! // Displays the quantity of the selected product
    @IBOutlet weak var totalLabel: UILabel! // Displays the total price based on quantity and selected product
    @IBOutlet weak var productLabel: UILabel! // Displays the name of the selected product
    @IBOutlet weak var tableView: UITableView! // Table view for displaying the list of products
    
    // Selected product and its row in the table view
    var selectedProduct: Product?
    var selectedRow: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the data source and delegate for the table view
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload the table view data whenever the view appears
        tableView.reloadData()
    }

    // Returns the number of rows in the table view (number of products)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductManager.shared.products.count
    }
    
    // Configures each cell in the table view with product information
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // Set the product name and price as the cell's text
        cell.textLabel?.text = ProductManager.shared.products[indexPath.row].name + " - $\(ProductManager.shared.products[indexPath.row].price)"
        // Set the available quantity as the cell's detail text
        cell.detailTextLabel?.text = String(ProductManager.shared.products[indexPath.row].quantity)
        return cell
    }
    
    // Handles selection of a product in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = ProductManager.shared.products[indexPath.row] // Store the selected product
        selectedRow = indexPath.row // Store the selected row index
        
        // Update the product label with the selected product's name
        productLabel.text = selectedProduct?.name
        
        // Calculate total if quantity is greater than 0
        if (Int(quantityLabel.text!)! > 0) {
            let total = selectedProduct!.price * Double(quantityLabel.text!)!
            totalLabel.text = String(format: "%.2f", total) // Format total to 2 decimal places
        }
    }
    
    // Handles keypad input for quantity
    @IBAction func keypadAction(_ sender: Any) {
        let keypad = sender as! UIButton // Get the tapped button
        let num = Int((keypad.titleLabel?.text)!) // Get the button's number
        // Update the quantity by multiplying the current quantity by 10 and adding the new number
        quantityLabel.text! = String(Int(quantityLabel.text!)! * 10 + num!)
        
        // Calculate total if a product is selected
        if ((selectedProduct) != nil) {
            let total = selectedProduct!.price * Double(quantityLabel.text!)!
            totalLabel.text = String(format: "%.2f", total)
        }
    }
    
    // Resets all fields to initial state
    @IBAction func clearAction(_ sender: Any) {
        quantityLabel.text! = "0" // Reset quantity
        totalLabel.text! = "0.0" // Reset total
        productLabel.text! = "" // Clear product label
        selectedProduct = nil // Clear selected product
        tableView.reloadData() // Reload table view data
    }
    
    // Deletes the last digit of the quantity
    @IBAction func deleteAction(_ sender: Any) {
        quantityLabel.text! = String(Int(quantityLabel.text!)! / 10) // Divide quantity by 10 to remove last digit
        
        // Calculate total if quantity is greater than 0
        if (Int(quantityLabel.text!)! > 0) {
            let total = selectedProduct!.price * Double(quantityLabel.text!)!
            totalLabel.text = String(format: "%.2f", total)
        }
    }
    
    // Handles the purchase action
    @IBAction func buyAction(_ sender: Any) {
        // Check if a product is selected and retrieve the quantity and total
        if let selectedProduct = selectedProduct, let quantity = quantityLabel.text, let total = Double(totalLabel.text!) {
            // Check for sufficient stock
            if Int(quantity)! > selectedProduct.quantity {
                let alert = UIAlertController(title: "Insufficient Stock", message: "The selected quantity for \(selectedProduct.name) exceeds the available stock of \(selectedProduct.quantity)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil) // Show alert
            } else {
                // Deduct the purchased quantity from stock
                ProductManager.shared.products[selectedRow!].quantity -= Int(quantity)!
                // Create a new history entry for the purchase
                let newHistory = History(date: Date(), product: selectedProduct.name, quantity: quantity, total: total)
                HistoryManager.shared.addHistory(newHistory) // Add to history manager
                
                // Show success alert
                let alert = UIAlertController(title: "Payment done Successfully", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                clearAction(self) // Clear all fields after purchase
            }
        }
    }
}
