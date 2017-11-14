//
//  UserAccounts.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    typealias userEmail = String
    typealias userUID = String
    let email:userEmail
    let uid:userUID
}

class LoginInfo {
    static let shared = LoginInfo()
    var user:User?
    var isLoggedIn:Bool {
        get {return user != nil}
    }
    let sharedAuth = Auth.auth()
    init() {
        sharedAuth.addStateDidChangeListener{ (auth,user) in
            guard let user = user else {return}
            guard let email = user.email else {return}
            self.user = User(email: email, uid: user.uid)
            
        }
    }
}

