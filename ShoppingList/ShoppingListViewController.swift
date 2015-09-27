//
//  ShoppingListViewController.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import UIKit

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
        
        let ban = Grocery(owner : "", amount : 2, productName : "Banana")
        let ban1 = Grocery(owner : "", amount : 5, productName : "Banana")
        let ban2 = Grocery(owner : "", amount : 6, productName : "Banana")
        let ban3 = Grocery(owner : "", amount : 8, productName : "Banana")
        let ban4 = Grocery(owner : "", amount : 10, productName : "Banana")
        let ban5 = Grocery(owner : "", amount : 12, productName : "Banana")
        let ban6 = Grocery(owner : "", amount : 3, productName : "Banana")
        
        let bananas = [ban, ban1, ban2, ban3, ban4, ban5, ban6]
        
        ownerShoppingList.appendContentsOf(bananas)
        
        listTableView.reloadData()
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
