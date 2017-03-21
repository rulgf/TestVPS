//
//  PacientModel.swift
//  TVPS
//
//  Created by SOFTAM03 on 3/7/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Pacient {
    let key: String
    let name: String
    let lastname_F: String
    let lastname_M: String
    let gender: String
    let grade: String
    let school: String
    let birth: String
    let cronAge: String
    let attentNote: String
    let visualNote: String
    let addedByUser: String
    let ref: FIRDatabaseReference?
    
    init(name: String, lastname_F: String, lastname_M: String,
         gender: String, grade: String, school: String, birth: String, cronAge: String,
         attentNote: String, visualNote: String, addedByUser: String, key: String = "") {
        self.key = key
        self.name = name
        self.lastname_F = lastname_F
        self.lastname_M = lastname_M
        self.gender = gender
        self.grade = grade
        self.school = school
        self.birth = birth
        self.cronAge = cronAge
        self .attentNote = attentNote
        self.visualNote = visualNote
        self.addedByUser = addedByUser
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        lastname_F = snapshotValue["lastname_F"] as! String
        lastname_M = snapshotValue["lastname_M"] as! String
        gender = snapshotValue["gender"] as! String
        grade = snapshotValue["grade"] as! String
        school = snapshotValue["school"] as! String
        birth = snapshotValue["birth"] as! String
        cronAge = snapshotValue["cronAge"] as! String
        attentNote = snapshotValue["attentNote"] as! String
        visualNote = snapshotValue["visualNote"] as! String
        addedByUser = snapshotValue["addedByUser"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "lastname_F": lastname_F,
            "lastname_M": lastname_M,
            "gender": gender,
            "grade": grade,
            "school": school,
            "birth": birth,
            "cronAge": cronAge,
            "attentNote": attentNote,
            "visualNote": visualNote,
            "addedByUser": addedByUser
        ]
    }
}
