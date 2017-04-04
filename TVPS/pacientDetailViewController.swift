//
//  pacientDetailViewController.swift
//  TVPS
//
//  Created by SOFTAM03 on 3/22/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit

class pacientDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var schoolLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var cronLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var attenLabel: UILabel!
    
    var pacient: Pacient?
    
    
    
    // Set up views if editing an existing Meal.

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let pacient = pacient {
            navigationItem.title = pacient.name
            nameLabel.text   = pacient.name
            lastnameLabel.text = pacient.lastname_F + " " + pacient.lastname_M
            genderLabel.text = pacient.gender
            schoolLabel.text = pacient.school
            gradeLabel.text = pacient.grade
            birthLabel.text = pacient.birth
            cronLabel.text = pacient.cronAge
            notesLabel.text = pacient.visualNote
            attenLabel.text = pacient.attentNote
            
        }
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

}
