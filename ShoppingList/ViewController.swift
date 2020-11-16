import UIKit

class ViewController: UITableViewController {
    var shoppingListItems = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTitle()
        setupRightBarButtonItem()
        setupLeftBarButtonItem()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shoppingListItems.isEmpty {
            tableView.setEmptyView(title: "The list is empty", message: "Tap the + button to add an item to the list.")
        } else {
            tableView.restore()
        }
        return shoppingListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItem", for: indexPath)
        cell.textLabel?.text = shoppingListItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingListItems.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @objc func addToList() {
        let ac = UIAlertController(title: "Enter Items", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submit = UIAlertAction(title: "Add", style: .default) {
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submitItem(newItem: item)
        }
        
        ac.addAction(submit)
        tableView.restore()
        present(ac, animated: true)
    }
    
    func submitItem(newItem: String) {
        if newItem.isEmpty { return }
        shoppingListItems.insert(newItem, at: 0)
        
        let placement = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [placement], with: .automatic)
    }
    
    func setUpTitle() {
        let shoppingListTitle = "Shopping List"
        title = shoppingListTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func deleteList() {
        let ac = UIAlertController(title: "Are you sure?", message: "This will delete the list.", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .destructive) { [weak self] _ in
            for _ in self!.shoppingListItems {
                self!.shoppingListItems.removeAll(keepingCapacity: true)
            }
            let sections = [0]
            self!.tableView.reloadSections(IndexSet(sections), with: .automatic)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(okButton)
        ac.addAction(cancelButton)
    
        present(ac, animated: true)
    }
    
    func setupRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToList))
    }
    
    func setupLeftBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteList))
    }
}



