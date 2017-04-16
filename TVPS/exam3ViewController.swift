//
//  exam3ViewController.swift
//  TVPS
//
//  Created by Gabriel Tejeda on 13/04/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseDatabase

class exam3ViewController: UIViewController {

    //MARK:Properties
    @IBOutlet weak var img0: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    var numberQuestion = 1
    var images = [String: UIImage]()
    var totalImages = ["1", "2", "3", "4", "5"]
    var errors = 0
    var allAnswers = ""
    var totalCorrect = 0
    
    var pacientKey:String?
    
    var testKey:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
        img0.isUserInteractionEnabled = true
        img1.isUserInteractionEnabled = true
        img2.isUserInteractionEnabled = true
        img3.isUserInteractionEnabled = true
        img4.isUserInteractionEnabled = true
        numberQuestion = 1
        
        
        initImage()
    }
    
    func initImage(){
        
        //Obtener tu pregunta
        images = ["1": UIImage(named: "TVPS_3_\(numberQuestion)_1.png")!,
                  "2": UIImage(named: "TVPS_3_\(numberQuestion)_2.png")!,
                  "3": UIImage(named: "TVPS_3_\(numberQuestion)_3.png")!,
                  "4": UIImage(named: "TVPS_3_\(numberQuestion)_4.png")!,
                  "5": UIImage(named: "TVPS_3_\(numberQuestion)_5.png")!]
        
        totalImages.shuffle()
        
        img0.image = images[totalImages[0]]
        img1.image = images[totalImages[1]]
        img2.image = images[totalImages[2]]
        img3.image = images[totalImages[3]]
        img4.image = images[totalImages[4]]
        
    }
    
    //Cambio de vistas
    func updateView() {
    }
    
    @IBAction func tap1Action(_ sender: UITapGestureRecognizer) {
        print("Tap 1")
        //VALIDAD RESPUESTA
        //si anterior es x entonces sumar contador error 1 solo si esta mal
        //contador error es 0
        
        //add 1 a numberQuestion
        //add 1 a seccion
        
        //initImage()
        if(totalImages[0] == "1"){
            updateScore(answer: true)
        }else{
            updateScore(answer: false)
        }
    }
    
    @IBAction func tap2Action(_ sender: UITapGestureRecognizer) {
        print("Tap 2")
        if(totalImages[1] == "1"){
            updateScore(answer: true)
        }else{
            updateScore(answer: false)
        }
    }
    
    @IBAction func tap3Action(_ sender: UITapGestureRecognizer) {
        print("Tap 3")
        if(totalImages[2] == "1"){
            updateScore(answer: true)
        }else{
            updateScore(answer: false)
        }
    }
    
    @IBAction func tap4Action(_ sender: UITapGestureRecognizer) {
        print("Tap 4")
        if(totalImages[3] == "1"){
            updateScore(answer: true)
        }else{
            updateScore(answer: false)
        }
    }
    
    @IBAction func tap5Action(_ sender: UITapGestureRecognizer) {
        print("Tap 5")
        if(totalImages[4] == "1"){
            updateScore(answer: true)
        }else{
            updateScore(answer: false)
        }
    }
    
    
    //updateScore
    func updateScore(answer: Bool){
        //Si esta en las primeras 2 preguntas no aumentar el numero de errores
        if(answer){
            allAnswers = allAnswers + "o"
            totalCorrect += 1
            errors = 0
            if(numberQuestion == 18){
                saveResult()
            }else{
                numberQuestion += 1
                initImage()
            }
        }else{
            allAnswers = allAnswers + "x"
            if(numberQuestion > 2){
                errors += 1
                if(errors >= 3 || numberQuestion == 18){
                    saveResult()
                }else{
                    numberQuestion += 1
                    initImage()
                }
            }
        }
    }
    
    //Save result
    func saveResult(){
        print("Fin, siguiente sección")
        //Mandar la respuesta a la base de datos
        //Edit
        let ref = FIRDatabase.database().reference().child("tvps/"+self.testKey!)
        
        ref.updateChildValues([
            "3res": totalCorrect-2,
            "3string": allAnswers
            ])
        
        //Cambio al siguiente test
        performSegue(withIdentifier: "endTest", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if(segue.identifier == "endTest"){
            guard let startTestViewController = segue.destination as? startTestViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            startTestViewController.testKey = self.testKey!
            startTestViewController.actualTest = 4
        }
    }

}
