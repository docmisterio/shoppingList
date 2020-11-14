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
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submitItem(newItem: item)
        }
        
        ac.addAction(submit)
        
        present(ac, animated: true)
        print(shoppingListItems)
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
        shoppingListItems = []
        let sections = [0]
        tableView.reloadSections(IndexSet(sections), with: .automatic)
    }
    
    func setupRightBarButtonItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToList))
    }
    
    func setupLeftBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteList))
    }
}



