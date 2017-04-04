//
//  examViewController.swift
//  TVPS
//
//  Created by Gabriel Tejeda on 04/04/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var opcionView: UIView!
    
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
        opcionView.isHidden = false
        
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
        img1.image = images["1"]
        img2.image = images["2"]
        img3.image = images["3"]
        img4.image = images["4"]
        
    }
    
    @IBAction func tap1Action(_ sender: UITapGestureRecognizer) {
        print("Tap 1")
        //VALIDAD RESPUESTA
        //si anterior es x entonces sumar contador error 1 solo si esta mal
        //contador error es 0
        
        //add 1 a numberQuestion
        //add 1 a seccion
        
        //initImage()
    }
    
    @IBAction func tap2Action(_ sender: UITapGestureRecognizer) {
        print("Tap 2")
    }
    
    @IBAction func tap3Action(_ sender: UITapGestureRecognizer) {
        print("Tap 3")
    }
    
    @IBAction func tap4Action(_ sender: UITapGestureRecognizer) {
        print("Tap 4")
    }
    
    //Cambio de vistas
    func updateView() {
        img0.isHidden = true
        opcionView.isHidden = false
        //STOP DEL TIMER
        timer.invalidate()
    }

}
