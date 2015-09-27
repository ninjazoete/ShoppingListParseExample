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

class RegisterViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        registerButton.rx_tap.subscribe { (event) -> Void in
            
            guard
                let typedUsername = self.usernameTextField.text,
                let typedPassword = self.passwordTextField.text
            else {
                    return
            }
            
            let userToRegister = User(username: typedUsername, password: typedPassword)
            
            ExternalDataService.registerUser(userToRegister)
                .subscribe(next: { (user) -> Void in
                    
                    /* User was registered */
                    self.performSegueWithIdentifier("ShoppingListForUserSegue", sender: self)
                    
                }, error: { (registerError) -> Void in
                    
                    /* Some shit error occured */
                    
                }, completed: { () -> Void in
                    
                    /* Everything is complete, signal is done */
                    
                }, disposed: nil)
        }
    }
    
    // MARK: Actions
    
    @IBAction func dismissDidClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
