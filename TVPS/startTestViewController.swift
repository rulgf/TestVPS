//
//  startTestViewController.swift
//  TVPS
//
//  Created by Gabriel Tejeda on 06/04/17.
//  Copyright © 2017 SOFTAM03. All rights reserved.
//

import UIKit

class startTestViewController: UIViewController {
    
    var timer = Timer()
    
    var pacienteKey:String?
    
    var testKey:String?
    
    var actualTest:Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        timer = Timer.scheduledTimer(timeInterval:5, target: self, selector: (#selector(startTestViewController.startNext)), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startNext() {
        performSegue(withIdentifier: "startTest\(self.actualTest!)", sender: nil)
        timer.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if(segue.identifier == "startTest1"){
            guard let examViewController = segue.destination as? examViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            examViewController.pacientKey = self.pacienteKey!
            
        }else if(segue.identifier == "startTest2"){
            guard let exam2ViewController = segue.destination as? exam2ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            exam2ViewController.testKey = self.testKey!

        }else if(segue.identifier == "startTest3"){
            guard let exam3ViewController = segue.destination as? exam3ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            exam3ViewController.testKey = self.testKey!
            
        }else if(segue.identifier == "startTest4"){
            guard let exam4ViewController = segue.destination as? exam4ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            exam4ViewController.testKey = self.testKey!
            
        }else if(segue.identifier == "startTest5"){
            guard let exam5ViewController = segue.destination as? exam5ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            exam5ViewController.testKey = self.testKey!
            
        }else if(segue.identifier == "startTest6"){
            guard let exam6ViewController = segue.destination as? exam6ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            exam6ViewController.testKey = self.testKey!
            
        }else if(segue.identifier == "startTest7"){
            guard let exam7ViewController = segue.destination as? exam7ViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            exam7ViewController.testKey = self.testKey!
            
        }
    }

}
