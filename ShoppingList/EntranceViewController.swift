//
//  EntranceViewController.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import UIKit

class EntranceViewController: FormViewController {

    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        
        self.actionClosure = { (user : User) -> Void in
            
            ExternalDataService.loginUser(user)
                .subscribe(next: { (regUser) -> Void in
                    
                    /* User was registered */
                    self.clearFields()
                    self.pushShoppingListViewController(regUser)
                    
                    }, error: { (registerError) -> Void in
                        /* Some shit error occured */
                        if
                            let err = registerError as? NSError,
                            let errorString = err.userInfo["error"] as? String
                        {
                            self.errorLabel.text = errorString
                        }
                        
                    }, completed: { () -> Void in
                        /* Everything is complete, signal is done */
                    }, disposed: nil)
        }
        
        
        super.viewDidLoad()
    }
    
    private func clearFields() -> Void {
        self.passwordTextField.text = ""
        self.usernameTextField.text = ""
        self.errorLabel.text = ""
    }
}
