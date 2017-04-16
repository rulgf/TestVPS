//
//  PacienteTableViewController.swift
//  TVPS
//
//  Created by SOFTAM03 on 3/10/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class PacienteTableViewController: UITableViewController {
    
    //MARK: Properties
    var pacientes = [Pacient]()
    //var user: User!
    
    var Uemail = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = FIRAuth.auth()?.currentUser {
             self.Uemail = user.email!
        } else {
            dismiss(animated: true, completion: nil)
        }
        
        let ref = FIRDatabase.database().reference(withPath: "pacients")
        
        ref.queryOrdered(byChild: "addedByUser").queryEqual(toValue: Uemail).observe(.value, with: { snapshot in
            var newPacients: [Pacient] = []
            
            for item in snapshot.children {
                let pacientItem = Pacient(snapshot: item as! FIRDataSnapshot)
                newPacients.append(pacientItem)
            }
            
            self.pacientes = newPacients
            self.tableView.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pacientes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PacienteTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PacienteTableViewCell  else {
            fatalError("The dequeued cell is not an instance of PacienteTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let paciente = pacientes[indexPath.row]
        
        
        cell.nameLabel.text = paciente.name + " " + paciente.lastname_F + " " + paciente.lastname_M
        cell.infoLabel.text = paciente.school
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        print(segue.description)
        
        if(segue.identifier != "addSegue"){
            guard let pacientDetailViewController = segue.destination as? pacientDetailViewController else {
             fatalError("Unexpected destination: \(segue.destination)")
             }
             
             guard let selectedPacientCell = sender as? PacienteTableViewCell else {
             fatalError("Unexpected sender: \(String(describing: sender))")
             }
             
             guard let indexPath = tableView.indexPath(for: selectedPacientCell) else {
             fatalError("The selected cell is not being displayed by the table")
             }
             
             let selectedPacient = pacientes[indexPath.row]
            
             pacientDetailViewController.pacient = selectedPacient
             
        }
    }
    
    
    //MARK: Actions
    /*@IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RegisterPacientViewController, let paciente = sourceViewController.pacient {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: pacientes.count, section: 0)
            
            pacientes.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }*/
    @IBAction func signoutButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //MARK: Private Methods
    
    private func loadSamplePacientes() {
    }

}
