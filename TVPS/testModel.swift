//
//  testModel.swift
//  TVPS
//
//  Created by Gabriel Tejeda on 15/04/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Test {
    let key: String
    let name: String
    let res1: Int
    let string1: String
    let res2: Int
    let string2: String
    let res3: Int
    let string3: String
    let res4: Int
    let string4: String
    let res5: Int
    let string5: String
    let res6: Int
    let string6: String
    let res7: Int
    let string7: String
    let date: String
    let appliedBy: String
    let ref: FIRDatabaseReference?
    
    init(name: String, res1: Int, string1: String, res2: Int, string2: String, res3: Int, string3: String, res4: Int, string4: String, res5: Int, string5: String, res6: Int, string6: String, res7: Int, string7: String, date: String, appliedBy: String, key: String) {
        self.key = key
        self.name = name
        self.res1 = res1
        self.string1 = string1
        self.res2 = res2
        self.string2 = string2
        self.res3 = res3
        self.string3 = string3
        self.res4 = res4
        self.string4 = string4
        self.res5 = res5
        self.string5 = string5
        self.res6 = res6
        self.string6 = string6
        self.res7 = res7
        self.string7 = string7
        self.date = date
        self.appliedBy = appliedBy
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot, name: String) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        self.name = name
        
        res1 = snapshotValue["1res"] as! Int
        string1 = snapshotValue["1string"] as! String
        
        res2 = snapshotValue["2res"] as! Int
        string2 = snapshotValue["2string"] as! String
        
        res3 = snapshotValue["3res"] as! Int
        string3 = snapshotValue["3string"] as! String
        
        res4 = snapshotValue["4res"] as! Int
        string4 = snapshotValue["4string"] as! String
        
        res5 = snapshotValue["5res"] as! Int
        string5 = snapshotValue["5string"] as! String
        
        res6 = snapshotValue["6res"] as! Int
        string6 = snapshotValue["6string"] as! String
        
        res7 = snapshotValue["7res"] as! Int
        string7 = snapshotValue["7string"] as! String
        
        date = snapshotValue["date"] as! String
        appliedBy = snapshotValue["appliedBy"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "key": key,
            "1res": res1,
            "1string": string1,
            "2res": res2,
            "2string": string2,
            "3res": res3,
            "3string": string3,
            "4res": res4,
            "4string": string4,
            "5res": res5,
            "5string": string5,
            "6res": res6,
            "6string": string6,
            "7res": res7,
            "7string": string7,
            "date": date,
            "appliedBy": appliedBy
        ]
    }
}
