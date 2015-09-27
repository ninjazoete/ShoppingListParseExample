//
//  DataProvider.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 26/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation
import RxSwift

#if PARSE
let ExternalDataService = DataService<ParseService>()
#endif


class DataService<S : Service> {
    
    private let internalService = S()
    
    // MARK: Public API
    func registerUser(user : User) -> Observable<User> {
        return internalService.registerUser(user)
    }
    
    func loginUser(user: User) -> Observable<User> {
        return internalService.loginUser(user)
    }
    
    // MARK: Private API
}