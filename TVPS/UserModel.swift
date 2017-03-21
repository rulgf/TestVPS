//
//  UserModel.swift
//  TVPS
//
//  Created by SOFTAM03 on 3/7/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseAuth

struct User{
    let uid: String
    let name: String
    let email: String
    
    init(authData: FIRUser) {
        uid = authData.uid
        name = authData.displayName!
        email = authData.email!
    }
    
    init(uid: String, name:String, email: String) {
        self.uid = uid
        self.name = name
        self.email = email
    }
    
}
