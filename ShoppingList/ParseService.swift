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
    
    func addGrocery(user: User, grocery: Grocery) -> Observable<Grocery> {
        return create({ (groceryAddObserver : ObserverOf<Grocery>) -> Disposable in
            self._parseAddGrocery(user, grocery: grocery, observer: groceryAddObserver)
            return NopDisposable.instance
            
        })
    }
    
    func fetchGroceries(user: User) -> Observable<[Grocery]> {
        return create({ (groceryFetchObserver : ObserverOf<[Grocery]>) -> Disposable in
            self._parseFetchGrocery(user, observer: groceryFetchObserver)
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
    
    private func _parseAddGrocery(user : User, grocery : Grocery, observer : ObserverOf<Grocery>) -> Void {
        
        guard
            let userId = user.objectId
        else {
            return
        }
        
        let groceryToAdd = PFObject(className: Grocery.parseClassName())
        groceryToAdd["productName"] = grocery.nameOfProduct
        groceryToAdd["productAmount"] = grocery.amount
        groceryToAdd["owner"] = userId
        
        groceryToAdd.saveInBackgroundWithBlock { (success, error) -> Void in
            
            if(success) {
                observer.on(Event.Next(grocery))
                observer.on(Event.Completed)
            } else if let err = error {
                observer.on(Event.Error(err))
            }
        }
    }
    
    private func _parseFetchGrocery(user : User, observer : ObserverOf<[Grocery]>) -> Void {
        
        guard
            let userId = user.objectId
            else {
                return
        }
        
        let groceryQuery = PFQuery(className: Grocery.parseClassName())
        groceryQuery.whereKey("owner", equalTo: userId)
        groceryQuery.findObjectsInBackgroundWithBlock { (groceries, error) -> Void in
            
            if let groceryList = groceries {
                
                let userGroceryList : [Grocery] = groceryList
                    .map({ (pfGrocery : PFObject) -> Grocery? in
                        
                        guard
                            let productName = pfGrocery["productName"] as? String,
                            let productAmount = pfGrocery["productAmount"] as? UInt
                        else {
                            return nil
                        }
                        
                        return Grocery(owner: userId, amount: productAmount, productName: productName)
                    })
                    .flatMap({ $0 })
            
                observer.on(Event.Next(userGroceryList))
                observer.on(Event.Completed)
            } else if let err = error {
                observer.on(Event.Error(err))
            }
            
        }
        
    }
}