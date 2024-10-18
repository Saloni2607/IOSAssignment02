import UIKit

class RestockViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Outlet for the quantity input field
    @IBOutlet weak var quantityOutlet: UITextField!
    
    // Outlet for the table view displaying products
    @IBOutlet weak var tableView: UITableView!
    
    // Variable to hold the selected product
    var selectedProduct: Product?
    
    // Variable to store the index of the selected row
    var selectedRow: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the data source and delegate for the table view
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - UITableViewDataSource
    
    // Returns the number of rows in the table view based on the number of products
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductManager.shared.products.count
    }
    
    // Configures the cell for each row in the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Dequeue a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Set the cell's text label to the product's name
        cell.textLabel?.text = ProductManager.shared.products[indexPath.row].name
        
        // Set the cell's detail text label to the product's quantity
        cell.detailTextLabel?.text = String(ProductManager.shared.products[indexPath.row].quantity)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    // Handles the selection of a row in the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Store the selected product and row index
        selectedProduct = ProductManager.shared.products[indexPath.row]
        selectedRow = indexPath.row
    }
    
    // Action triggered when the restock button is pressed
    @IBAction func restockAction(_ sender: Any) {
        // Check if a row is selected and if the quantity input is a valid integer
        if let selectedRow, let quantity = Int(quantityOutlet.text!) {
            // Update the quantity of the selected product
            ProductManager.shared.products[selectedRow].quantity = quantity
            
            // Show success alert
            let alert = UIAlertController(title: "Quantity Updated Successfully", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
            // Reload the table view to reflect changes
            tableView.reloadData()
        } else if selectedRow == nil {
            // Show error alert if no product is selected
            let alert = UIAlertController(title: "Error", message: "Please select a product", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
            // Show error alert if the quantity input is invalid
            let alert = UIAlertController(title: "Error", message: "Please enter a valid quantity", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    // Action triggered when the cancel button is pressed
    @IBAction func cancelAction(_ sender: Any) {
        // Navigate back to the previous view controller
        self.navigationController?.popViewController(animated: true)
    }
}
