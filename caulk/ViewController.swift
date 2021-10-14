//
//  ViewController.swift
//  caulk
//
//  Created by nju on 2021/10/9.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dispalyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dispalyLabel.text! = ""
    }
    var digitonDisplay: String{
        get{
            return self.dispalyLabel.text!
        }
        set{
            self.dispalyLabel.text! = newValue
        }
    }
    var inTypingMode = false
    
    
    @IBAction func numberTouched(_ sender: UIButton) {
        if inTypingMode{
            digitonDisplay = digitonDisplay + sender.currentTitle!
        }else{
            digitonDisplay = sender.currentTitle!
            inTypingMode = true
        }
    }
    let calculator = calculk()
    
    @IBAction func operationbt(_ sender: UIButton) {
        if let op = sender.currentTitle{
            if let result = calculator.performOperation(operation: op, operand: Double(digitonDisplay)!){
                digitonDisplay = String(result)
            }
            inTypingMode = false
        }
    }
    
}

