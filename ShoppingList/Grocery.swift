//
//  Grocery.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation

class Grocery : ParseServiceCompatible {
    
    let ownerId : String
    let amount : UInt
    let nameOfProduct : String
    
    init(owner : String, amount : UInt, productName : String) {
        
        self.ownerId = owner
        self.amount = amount
        self.nameOfProduct = productName
    }
    
    static func parseClassName() -> String {
        return "Grocery"
    }
}
