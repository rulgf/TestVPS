//
//  pacientDetailViewController.swift
//  TVPS
//
//  Created by SOFTAM03 on 3/22/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseDatabase

class pacientDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    var exams = [Test]()
    
    @IBOutlet weak var examTable: UITableView!
    
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
        
        //Cargar examenes paciente
        let ref = FIRDatabase.database().reference(withPath: "tvps")
        
        ref.queryOrdered(byChild: "appliedBy").queryEqual(toValue: self.pacient?.key).observe(.value, with: { snapshot in
            var newTests: [Test] = []
            
            for item in snapshot.children {
                let testItem = Test(snapshot: item as! FIRDataSnapshot, name: "TVPS")
                newTests.append(testItem)
            }
            
            self.exams = newTests
            self.examTable.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        print(segue.description)
        
        if(segue.identifier == "editSegue"){
            guard let editPacientViewController = segue.destination as? editPacientViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            editPacientViewController.pacient = self.pacient
            
        }else if(segue.identifier == "startTVPS"){
            guard let startTestViewController = segue.destination as? startTestViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            startTestViewController.pacienteKey = (self.pacient?.key)!
            startTestViewController.actualTest = 1
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return(self.exams.count)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = self.exams[indexPath.row].name
        cell.detailTextLabel?.text = self.exams[indexPath.row].date
        
        return cell
    }
    


}
