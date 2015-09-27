//
//  Apple.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation

class Apples : Grocery, ParseServiceCompatible {
    static func parseClassName() -> String {
        return "GroceryApples"
    }
}

class Bananas : Grocery, ParseServiceCompatible {
    static func parseClassName() -> String {
        return "GroceryBananas"
    }
}

class Carrots : Grocery, ParseServiceCompatible {
    static func parseClassName() -> String {
        return "GroceryCarrots"
    }
}

class Grapes : Grocery, ParseServiceCompatible {
    static func parseClassName() -> String {
        return "GroceryGrapes"
    }
}