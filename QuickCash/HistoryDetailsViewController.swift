import UIKit

// View controller for displaying the details of a purchase history item
class HistoryDetailsViewController: UIViewController {
    
    // Outlets for the labels to display purchase details
    @IBOutlet weak var nameLabel: UILabel!      // Label for displaying the product name
    @IBOutlet weak var quantityLabel: UILabel!   // Label for displaying the quantity purchased
    @IBOutlet weak var totalLabel: UILabel!      // Label for displaying the total price of the purchase
    @IBOutlet weak var dateLabel: UILabel!       // Label for displaying the date of purchase
    
    // Index of the selected history item
    var selectedIndex: Int = 0

    // Method called after the view has loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the nameLabel to the product name from the selected history item
        nameLabel.text = HistoryManager.shared.history[selectedIndex].product
        
        // Set the quantityLabel to the quantity from the selected history item
        quantityLabel.text = "Quantity: " + HistoryManager.shared.history[selectedIndex].quantity
        
        // Set the totalLabel to the total price from the selected history item
        totalLabel.text = "Total: " + String(HistoryManager.shared.history[selectedIndex].total)
        
        // Get the date of the selected history item
        let date = HistoryManager.shared.history[selectedIndex].date
        
        // Create a date formatter to format the date for display
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy" // Set the date format
        
        // Convert the date to a string using the formatter
        let dateString = dateFormatter.string(from: date)
        
        // Set the dateLabel to the formatted date string
        dateLabel.text = "Date: " + dateString
    }
}
