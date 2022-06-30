//
//  ViewController.swift
//  QRLists
//
//  Created by Jorge Collins Gómez on 28/06/22.
//

import UIKit

// "QR" en lugar de "Todo"
class QRListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        print(dataFilePath!)

        loadItems()
    }

    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QRItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    
    //MARK: TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.deselectRow(at: indexPath, animated: true)
        
        self.saveItems()
    }
    
    
    //MARK: - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New List", message: "", preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new list"
            textField = alertTextField
        }
        
        let action = UIAlertAction(title: "Add list", style: .default) { action in
            
            if textField.text != "" {
                
                let newItem = Item()
                newItem.title = textField.text!
                
                self.itemArray.append(newItem)
                
                self.saveItems()
                
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            self.dismiss(animated: true)
        }
        
        alert.addAction(action)
        alert.addAction(actionCancel)
        present(alert, animated: true)
    }
    
    
    //MARK: - Model manipulation
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding items, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding items, \(error)")
            }
            
        }
    }


}

