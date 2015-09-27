//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import UIKit
import Parse

class ShoppingListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var listTableView: UITableView!
    
    var listOwner : User?
    var ownerShoppingList : [Grocery] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchOwnerList()
    }
    
    // MARK: Data
    private func fetchOwnerList() -> Void {
        
        listOwner = PFUser.currentUser() as? User
        
        if let user = listOwner {
            ExternalDataService.fetchGroceries(user).subscribe(next: { (groceryList) -> Void in
                
                self.ownerShoppingList.appendContentsOf(groceryList)
                self.listTableView.reloadData()
                
                }, error: { (error) -> Void in
                    print(error)
                }, completed: { () -> Void in
                    
                }, disposed: nil)
        }
    }
    
    // MARK: Delegates
    func tableView(
        tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("GroceryCell", forIndexPath: indexPath)
            
            if let groceryCell = cell as? GroceryTableViewCell {
                
                let groceryAtIndexPath = ownerShoppingList[indexPath.row]
                groceryCell.productNameLabel.text = groceryAtIndexPath.nameOfProduct
                groceryCell.productAmountLabel.text = String(groceryAtIndexPath.amount)
            }
            
            return cell
    }
    
    func tableView(
        tableView: UITableView,
        numberOfRowsInSection
        section: Int) -> Int {
            
            return ownerShoppingList.count
    }
    
    func numberOfSectionsInTableView(
        tableView: UITableView) -> Int {
        return 1
    }

}
