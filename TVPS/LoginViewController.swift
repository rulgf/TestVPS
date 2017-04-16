//
//  LoginViewController.swift
//  TVPS
//
//  Created by SOFTAM03 on 3/7/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPassTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Save User in DB
    @IBAction func saveUser(_ sender: UIButton) {
        
        print("Registrando...")
        
        let name = nameTextField.text
        let email = emailTextField.text
        let passwd = passwordTextField.text
        let repeatPass = repeatPassTextField.text
        
        if(name != "" && email != "" && passwd != "" && repeatPass != ""){
            //Verificar que la contraseña es igual
            if(passwd == repeatPass){
                // Crear el usuario
                FIRAuth.auth()!.createUser(withEmail: email!,
                                           password: passwd!) { user, error in
                                            if error == nil {
                                                // Iniciar sesión para el usuario actual
                                                FIRAuth.auth()!.signIn(withEmail: email!,
                                                                       password: passwd!)
                                            }else{
                                                let alert = UIAlertController(title: "Error", message: "No se pudo hacer el registro, intente más tarde", preferredStyle: UIAlertControllerStyle.alert)
                                                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                                                self.present(alert, animated: true, completion: nil)
                                            }
                }
                //Actualizar el nombre del usuario con el texto ingresado
                let user = FIRAuth.auth()?.currentUser
                
                if let user = user {
                    let changeRequest = user.profileChangeRequest()
                    
                    changeRequest.displayName = name
                    
                    let alert = UIAlertController(title: "Registro exitoso", message: "El usuario ha sido registrado en el sistema", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    dismiss(animated: true, completion: nil)
                }
            }else{
                let alert = UIAlertController(title: "Contraseñas", message: "Las contraseñas no coinciden", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            let alert = UIAlertController(title: "Campos vacíos", message: "Favor de llenar los campos para poder hacer el registro", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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

}
