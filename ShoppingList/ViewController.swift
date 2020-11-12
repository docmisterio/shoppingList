import UIKit

class ViewController: UITableViewController {
    var shoppingListItems = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToList))
        
        
        shoppingListItems = []
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel?.text = shoppingListItems[indexPath.row]
        return cell
    }
    
    @objc func addToList() {
        let ac = UIAlertController(title: "Enter Items", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submit = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] things in
            guard let item = ac?.textFields?[0].text else { return }
        }
        
        ac.addAction(submit)
        
        present(ac, animated: true)
        print(shoppingListItems)
    }
}



