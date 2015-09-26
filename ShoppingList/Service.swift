//
//  Service.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 26/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation

typealias NoRActionCallback = ErrorType -> Void

protocol Service {
    init()
    func registerUser(user : User, callback : NoRActionCallback)
    func loginUser(user : User, callback : NoRActionCallback)
    
}