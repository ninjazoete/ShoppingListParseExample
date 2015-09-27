//
//  Grocery.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation

class Grocery {
    
    let ownerName : String
    let amount : UInt
    let nameOfProduct : String
    
    init(owner : String, amount : UInt, productName : String) {
        
        self.ownerName = owner
        self.amount = amount
        self.nameOfProduct = productName
    }
}