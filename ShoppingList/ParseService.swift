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
    
    func registerUser(user : User) -> Observable<User> {
        return create({ (userRegisterObserver : ObserverOf<User>) -> Disposable in
            self._parseRegisterUser(user, observer: userRegisterObserver)
            return NopDisposable.instance
        })
    }
    
    func loginUser(user : User) -> Observable<User> {
        return create({ (userLoginObserver : ObserverOf<User>) -> Disposable in
            self._parseLoginUser(user, observer: userLoginObserver)
            return NopDisposable.instance
        })
    }
    
    // MARK: Parse Actions
    private func _parseRegisterUser(user : User, observer : ObserverOf<User>) -> Void {
        
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            
            if(success) {
                observer.on(Event.Next(user))
                observer.on(Event.Completed)
            } else if let err = error {
                observer.on(Event.Error(err))
            }
        }
    }
    
    private func _parseLoginUser(user : User, observer : ObserverOf<User>) -> Void {
        
        guard
            let typedUsername = user.username,
            let typedPassword = user.password
        else {
            return
        }
        
        User.logInWithUsernameInBackground(
            typedUsername,
            password: typedPassword) { (loggedUser, error) -> Void in
            
                if let err = error {
                    observer.on(Event.Error(err))
                } else if let _ = loggedUser {
                    observer.on(Event.Next(user))
                    observer.on(Event.Completed)
                }
        }
    }
}