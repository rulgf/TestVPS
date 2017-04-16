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
    let email: String
    
    init(authData: FIRUser) {
        print("INFO!!!!!!")
        uid = authData.uid
        email = authData.email!
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
