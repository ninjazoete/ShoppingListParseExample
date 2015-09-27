//
//  Vegetables.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 27/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation

class Celery : Grocery, ParseServiceCompatible {
    static func parseClassName() -> String {
        return "GroceryCelery"
    }
}

class Cabagge : Grocery, ParseServiceCompatible {
    static func parseClassName() -> String {
        return "GroceryCabagge"
    }
}