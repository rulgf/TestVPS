//
//  RegisterPacientViewController.swift
//  TVPS
//
//  Created by SOFTAM03 on 3/12/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseDatabase

class RegisterPacientViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameF: UITextField!
    @IBOutlet weak var lastNameM: UITextField!
    @IBOutlet weak var maleSwitch: UISwitch!
    @IBOutlet weak var femaleSwitch: UISwitch!
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var birthDatePicker: UIDatePicker!
    @IBOutlet weak var cronDatePicker: UIDatePicker!
    @IBOutlet weak var visualNotesTextField: UITextField!
    @IBOutlet weak var attentionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var user: User!
    
    let ref = FIRDatabase.database().reference(withPath: "pacients")
    let usersRef = FIRDatabase.database().reference(withPath: "online")
    
    var genderString = "male"
    var birthString = ""
    var cronString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        nameTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        lastNameF.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        lastNameM.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        gradeTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        schoolTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
    }
    
    func editingChanged(_ textField: UITextField) {
        if textField.text?.characters.count == 1 {
            if textField.text?.characters.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let name = nameTextField.text, !name.isEmpty,
            let lastNameF = lastNameF.text, !lastNameF.isEmpty,
            let lastNameM = lastNameM.text, !lastNameM.isEmpty,
            let grade = gradeTextField.text, !grade.isEmpty,
            let school = schoolTextField.text, !school.isEmpty
            else {
                saveButton.isEnabled = false
                return
        }
        saveButton.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Actions
    @IBAction func genderMaleAction(_ sender: UISwitch) {
        if(femaleSwitch.isOn){
            femaleSwitch.setOn(false, animated: true)
        }
        if(!maleSwitch.isOn){
            femaleSwitch.setOn(true, animated: true)
        }else{
            genderString = "male"
        }
    }
    
    @IBAction func genderFemaleAction(_ sender: Any) {
        if(maleSwitch.isOn){
            maleSwitch.setOn(false, animated: true)
        }
        if(!femaleSwitch.isOn){
            maleSwitch.setOn(true, animated: true)
        }else{
            genderString = "female"
        }
    }
    
    @IBAction func birthAction(_ sender: Any) {
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: birthDatePicker.date)
        let month = calendar.component(.month, from: birthDatePicker.date)
        let day = calendar.component(.day, from: birthDatePicker.date)
        
        cronString = day.description + "/" + month.description + "/" + year.description
        
    }
    
    @IBAction func cronAction(_ sender: Any) {
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: cronDatePicker.date)
        let month = calendar.component(.month, from: cronDatePicker.date)
        let day = calendar.component(.day, from: cronDatePicker.date)
        
        birthString = day.description + "/" + month.description + "/" + year.description
    }
    
    @IBAction func savePacientAction(_ sender: UIBarButtonItem) {
        print("Saving...")
        
        let name = nameTextField.text ?? ""
        let lastnameF = lastNameF.text ?? ""
        let lastnameM = lastNameM.text ?? ""
        let gender = genderString
        let grade = gradeTextField.text ?? ""
        let school = schoolTextField.text ?? ""
        let birth = birthString
        let cronAge = cronString
        let noteVisual = visualNotesTextField.text ?? ""
        let noteAttention = attentionTextField.text ?? ""
        
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        let paciente = Pacient(name: name, lastname_F: lastnameF, lastname_M: lastnameM, gender: gender, grade: grade, school: school, birth: birth, cronAge: cronAge, attentNote: noteAttention, visualNote: noteVisual, addedByUser: "prueba@prueba.com")
        //self.user.email
        
        let pacientItemRef = self.ref.child(name + " " + lastnameF + " " + lastnameM)
        
        pacientItemRef.setValue(paciente.toAnyObject())
        
        performSegue(withIdentifier: "PacienteTableViewController", sender: self)
    }
    
    

}
