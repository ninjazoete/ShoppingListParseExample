//
//  Service.swift
//  ShoppingList
//
//  Created by Andrzej Spiess on 26/09/15.
//  Copyright © 2015 Sweaty Fingers. All rights reserved.
//

import Foundation
import RxSwift

protocol Service {
    init()
    func registerUser(user : User) -> Observable<User>
    func loginUser(user : User) -> Observable<User>
    func addGrocery(user : User, grocery : Grocery) -> Observable<Grocery>
    func fetchGroceries(user : User) -> Observable<[Grocery]>
}