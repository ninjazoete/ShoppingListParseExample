//
//  FormViewController.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    var actionClosure : (User -> Void)?
    
    @IBOutlet weak var formButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        formButton.rx_tap.subscribe { (event) -> Void in
            
            guard
                let typedUsername = self.usernameTextField.text,
                let typedPassword = self.passwordTextField.text
                else {
                    return
            }
            
            let userToRegister = User()
            userToRegister.username = typedUsername
            userToRegister.password = typedPassword
            
            if let action = self.actionClosure {
                action(userToRegister)
            }
        }
    }
}
