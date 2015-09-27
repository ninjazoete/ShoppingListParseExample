//
//  UIViewController+Navigation.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation

extension UIViewController {
    
    func pushShoppingListViewController(user : User) -> Void {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let listController = storyboard.instantiateViewControllerWithIdentifier("ShoppingListViewController")
        
        if let shoppingListController = listController as? ShoppingListViewController {
            shoppingListController.listOwner = user
            self.navigationController?.pushViewController(shoppingListController, animated: true)
        }
    }
}