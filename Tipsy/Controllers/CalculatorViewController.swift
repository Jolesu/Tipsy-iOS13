//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var bill: Float = 0.0
    var tip: Float = 1.1
    var numberOfPeople = 2
    var total = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        
        if sender.currentTitle == "0%" {
            tip = 1.0
        } else if sender.currentTitle == "10%" {
            tip = 1.1
        } else if sender.currentTitle == "20%" {
            tip = 1.2
        }
        
        billTextField.endEditing(true)
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill: Float = Float(billTextField.text!) ?? 0.0
        let billWithTip = bill * tip
        numberOfPeople = Int(splitNumberLabel.text!)!
        total = String(format: "%.2f", billWithTip/Float(numberOfPeople))
        self.performSegue(withIdentifier: "goToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = total
            destinationVC.tip = Int((tip - 1.0)*100)
            destinationVC.split = numberOfPeople
        }
    }
}
