//
//  User.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 26/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation

class User {
    
    let username : String
    let password : String
    
    init(username : String, password : String) {
        self.username = username
        self.password = password
    }
}

extension User : ParseServiceCompatible {
    static func parseClassName() -> String {
        return "User"
    }
}