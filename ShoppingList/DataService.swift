//
//  DataProvider.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 26/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation

#if PARSE
let ExternalDataService = DataService<ParseService>()
#endif


class DataService<S : Service> {
    
    private let internalService = S()
    
    // MARK: Public API
    func registerUser(user : User, callback : NoRActionCallback) -> Void {
        internalService.registerUser(user, callback: callback)
    }
    
    func loginUser(user: User, callback: NoRActionCallback) {
        internalService.loginUser(user, callback: callback)
    }
    
    // MARK: Private API
}