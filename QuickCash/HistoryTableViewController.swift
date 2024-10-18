import UIKit

class HistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup can be done here if needed.
    }

    // MARK: - Table view data source

    // Returns the number of sections in the table view.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Returns the number of rows in a given section.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the count of history entries managed by HistoryManager.
        return HistoryManager.shared.history.count
    }

    // Configures and returns the cell for a particular row in the table view.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Print the quantity of the history entry for debugging purposes.
        print(HistoryManager.shared.history[indexPath.row].quantity)

        // Dequeue a reusable cell with the identifier "cell".
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Set the text label of the cell to the product name.
        cell.textLabel?.text = HistoryManager.shared.history[indexPath.row].product

        // Set the detail text label of the cell to the quantity.
        cell.detailTextLabel?.text = String(HistoryManager.shared.history[indexPath.row].quantity)

        return cell
    }
    
    // Prepares for navigation before a segue occurs.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "details" {
            // Get the destination view controller and set the selected index.
            let detailView = segue.destination as! HistoryDetailsViewController
            detailView.selectedIndex = tableView.indexPathForSelectedRow!.row
        }
    }
}
