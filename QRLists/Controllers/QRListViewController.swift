//
//  ViewController.swift
//  QRLists
//
//  Created by Jorge Collins Gómez on 28/06/22.
//

import UIKit
import CoreData

// "QR" en lugar de "Todo"
class QRListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
//        print(dataFilePath!)
        print("--- viewDidLoad")
        
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
                
                
                let newItem = Item(context: self.context)
                newItem.title = textField.text!
                newItem.done = false
                
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
        
        do {
            try context.save()
        } catch {
            print("Error encoding items, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
    }


}

