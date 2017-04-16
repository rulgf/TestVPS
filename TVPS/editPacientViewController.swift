//
//  editPacientViewController.swift
//  TVPS
//
//  Created by Gabriel Tejeda on 08/04/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseDatabase

class editPacientViewController: UIViewController {
    
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
    
    let ref = FIRDatabase.database().reference(withPath: "pacients")
    
    var genderString = "Masculino"
    var birthString = ""
    var cronString = ""
    
    var pacient: Pacient?
    
    var key = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        saveButton.isEnabled = false
        nameTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        lastNameF.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        lastNameM.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        gradeTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        schoolTextField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
        nameTextField.text = self.pacient?.name
        lastNameF.text = self.pacient?.lastname_F
        lastNameM.text = self.pacient?.lastname_M
        schoolTextField.text = self.pacient?.school
        gradeTextField.text = self.pacient?.grade
        visualNotesTextField.text = self.pacient?.visualNote
        attentionTextField.text = self.pacient?.attentNote
        birthString = (self.pacient?.birth)!
        
        key = (self.pacient?.key)!
        
        if(self.pacient?.gender == "Masculino"){
            maleSwitch.isOn = true
            femaleSwitch.isOn = false
            genderString = "Masculino"
        }else{
            maleSwitch.isOn = false
            femaleSwitch.isOn = true
            genderString = "Femenino"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/M/yyyy"
        if let convertedStartDate = dateFormatter.date(from: (self.pacient?.birth)!) {
            print(convertedStartDate)
            birthDatePicker.setDate(convertedStartDate, animated: false)
        }
        
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
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "principalSegue", sender: nil)
    }
    
    //MARK: Actions
    @IBAction func genderMaleAction(_ sender: UISwitch) {
        if(femaleSwitch.isOn){
            femaleSwitch.setOn(false, animated: true)
        }
        if(!maleSwitch.isOn){
            femaleSwitch.setOn(true, animated: true)
        }else{
            genderString = "Masculino"
        }
    }
    
    @IBAction func genderFemaleAction(_ sender: Any) {
        if(maleSwitch.isOn){
            maleSwitch.setOn(false, animated: true)
        }
        if(!femaleSwitch.isOn){
            maleSwitch.setOn(true, animated: true)
        }else{
            genderString = "Femenino"
        }
    }
    
    @IBAction func birthAction(_ sender: Any) {
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: birthDatePicker.date)
        let month = calendar.component(.month, from: birthDatePicker.date)
        let day = calendar.component(.day, from: birthDatePicker.date)
        
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
        
        //Edit
        let ref = FIRDatabase.database().reference().child("pacients/"+key)
        
        ref.updateChildValues([
            "name": name,
            "lastname_F": lastnameF,
            "lastname_M": lastnameM,
            "gender": gender,
            "grade": grade,
            "school": school,
            "birth": birth,
            "cronAge": cronAge,
            "attentNote": noteAttention,
            "visualNote": noteVisual
            ])
        
        performSegue(withIdentifier: "principalSegue", sender: nil)
        
    }
    
    @IBAction func deletePacient(_ sender: UIButton) {
        let alert = UIAlertController(title: "Eliminar Usuario", message: "Esta seguro de eliminar el usuario", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Sí", style: UIAlertActionStyle.default, handler: {action in self.eliminar()}))
        alert.addAction(UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func eliminar(){
        let ref = FIRDatabase.database().reference().child("pacients/"+key)
        
        ref.removeValue()
        performSegue(withIdentifier: "principalSegue", sender: nil)
    }
    

}
