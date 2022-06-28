//
//  ViewController.swift
//  QRLists
//
//  Created by Jorge Collins Gómez on 28/06/22.
//

import UIKit

class QRListViewController: UITableViewController {

    let itemArray = ["Item 1", "List 2", "Task 3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // "QR" en lugar de "Todo"
    }

    
    //MARK - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QRItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

}

