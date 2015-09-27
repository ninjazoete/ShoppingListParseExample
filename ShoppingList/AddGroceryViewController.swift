//
//  AddGroceryViewController.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Parse

class AddGroceryViewController : UIViewController {

    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var productAmountTextField: UITextField!
    @IBOutlet weak var addGroceryButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = PFUser.currentUser() as? User

        addGroceryButton.rx_tap.subscribe { (event) -> Void in
            
            guard
                let typedProductName = self.productNameTextField.text,
                let typedProductAmount = self.productAmountTextField.text,
                let productAmount = UInt(typedProductAmount),
                let user = currentUser,
                let userId = currentUser?.objectId
            else {
                return
            }
                
            let groceryToAdd = Grocery(owner: userId, amount: productAmount, productName: typedProductName)
            
            ExternalDataService.addGrocery(user, grocery: groceryToAdd).subscribe(next: { (grocery) -> Void in
                
                }, error: { (error) -> Void in
                    
                }, completed: { () -> Void in
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }, disposed: nil)
        }
        
        // Dismissing modal.
        closeButton.rx_tap.subscribe { (event) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
