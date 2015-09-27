//
//  ParseService.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 26/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation
import RxSwift
import Parse

protocol ParseServiceCompatible : class {
    static func parseClassName() -> String
}

class ParseService : Service {
    
    required init() { }
    
    // MARK: Public API
    
    func registerUser(user: User) -> Observable<User> {
        return create({ (userRegisterObserver : ObserverOf<User>) -> Disposable in
            self._parseRegisterUser(user, observer: userRegisterObserver)
            return NopDisposable.instance
        })
    }
    
    func loginUser(user: User) -> Observable<User> {
        return just(User(username: "bla", password: "bla"))
    }
    
    // MARK: Parse Actions
    private func _parseRegisterUser(user : User, observer : ObserverOf<User>) -> Void {
        let userToRegister = PFObject(className: User.parseClassName())
        userToRegister["username"] = user.username
        userToRegister["password"] = user.password
        
        userToRegister.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                observer.on(Event.Next(user))
                observer.on(Event.Completed)
            } else if let err = error {
                observer.on(Event.Error(err))
            }
        }
    }
}