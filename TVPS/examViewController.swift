//
//  examViewController.swift
//  TVPS
//
//  Created by Gabriel Tejeda on 04/04/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension Array {
    mutating func shuffle () {
        for i in (0..<self.count).reversed() {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i+1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
}

class examViewController: UIViewController {

    @IBOutlet weak var img0: UIImageView!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var img4: UIImageView!
    
    var numberSection = 1
    var numberQuestion = 1
    var images = [String: UIImage]()
    var timer = Timer()
    var totalImages = ["1", "2", "3", "4"]
    var errors = 0
    var allAnswers = ""
    var totalCorrect = 0
    
    let ref = FIRDatabase.database().reference(withPath: "tvps")
    var pacientKey:String?
    
    var key:String?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool){
        img1.isUserInteractionEnabled = true
        img2.isUserInteractionEnabled = true
        img3.isUserInteractionEnabled = true
        img4.isUserInteractionEnabled = true
        numberQuestion = 1
        
        //Validar
        img0.isHidden = false
        
        initImage()
    }
    
    func initImage(){
        /*timer = Timer.scheduledTimer(timeInterval:5, target: self, selector: (#selector(examViewController.updateView)), userInfo: nil, repeats: true)
        */
        //Obtener tu pregunta
        img0.image = UIImage(named: "TVPS_\(numberSection)_\(numberQuestion)_0.png")!
        images = ["1": UIImage(named: "TVPS_\(numberSection)_\(numberQuestion)_1.png")!,
                  "2": UIImage(named: "TVPS_\(numberSection)_\(numberQuestion)_2.png")!,
                  "3": UIImage(named: "TVPS_\(numberSection)_\(numberQuestion)_3.png")!,
                  "4": UIImage(named: "TVPS_\(numberSection)_\(numberQuestion)_4.png")!]
        
        totalImages.shuffle()
        
        print(totalImages)
        
        img1.image = images[totalImages[0]]
        img2.image = images[totalImages[1]]
        img3.image = images[totalImages[2]]
        img4.image = images[totalImages[3]]
        
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
    
    //Cambio de vistas
    func updateView() {
        img0.isHidden = true
        //STOP DEL TIMER
        timer.invalidate()
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
        //Mandar la respuesta a la base de datos
        let todaysDate:Date = Date()
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy-HH:mm"
        let DateInFormat:String = dateFormatter.string(from: todaysDate)
        
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateTest:String = dateFormatter.string(from: todaysDate)
        
        self.key = DateInFormat+"TVPS"+self.pacientKey!
        
        let examItemRef = self.ref.child(self.key!)
        
        examItemRef.setValue(
            [
                "key": self.key!,
                "1string": self.allAnswers,
                "1res": totalCorrect - 2,
                "2string": "",
                "2res": 0,
                "3string": "",
                "3res": 0,
                "4string": "",
                "4res": 0,
                "5string": "",
                "5res": 0,
                "6string": "",
                "6res": 0,
                "7string": "",
                "7res": 0,
                "appliedBy": self.pacientKey!,
                "date": dateTest
            ]
        )
        
        
        //Cambio al siguiente test
        performSegue(withIdentifier: "endTest", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if(segue.identifier == "endTest"){
            guard let startTestViewController = segue.destination as? startTestViewController else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            startTestViewController.testKey = self.key!
            startTestViewController.actualTest = 2
        }
    }

}
