//
//  RegisterViewController.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 26/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: FormViewController {
    
    override func viewDidLoad() {
        
        self.actionClosure = { (user : User) -> Void in

            ExternalDataService.registerUser(user)
                .subscribe(next: { (regUser) -> Void in
                    
                    /* User was registered */
                    self.pushShoppingListViewController(regUser)
                    
                    }, error: { (registerError) -> Void in
                        /* Some shit error occured */
                        
                    }, completed: { () -> Void in
                        /* Everything is complete, signal is done */
                    }, disposed: nil)
        }
    
        super.viewDidLoad()
    }
    
    // MARK: Actions
    
    @IBAction func dismissDidClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
