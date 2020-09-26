//
//  ViewController.swift
//  CIS357-HW3
//
//  Created by Shayla Hinkley on 9/26/20.
//  Copyright © 2020 Shayla Hinkley. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var titleAppLabel: UILabel!
    
    @IBOutlet weak var topTextField: DecimalMinusTextField!

    @IBOutlet weak var bottomTextField: DecimalMinusTextField!
    
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var bottomLabel: UILabel!
    
    var passTopLabel: String!
    var passBottomLabel: String!
    var passMode: String!
    var topLabelPass: String?
    var bottomLabelPass: String?
    var modePass: String?
    
    //variable for the mode that the 
    var mode: String = "length"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if modePass == nil {
            whatMode(input: mode)
        } else {
            whatMode(input: modePass!)
        }
        
        //keyboard disapears when return key hit
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        
        if let hasTopLabel = self.topLabelPass {
            self.topLabel.text = hasTopLabel
        }
        
        if let hasBottomLabel = self.bottomLabelPass {
                   self.bottomLabel.text = hasBottomLabel
        }
        self.loadData()
        
    }
    func loadData() {
        self.reloadInputViews()
    }
    
    func whatMode(input: String) {
        mode = input
        
        if mode == "length" {
            titleAppLabel.text = "Length Conversion Calculator"
        } else {
            titleAppLabel.text = "Volume Conversion Calculator"
        }
    }
    
    //sending data over to the settings view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToSettings" {
//            if let dest = segue.destination as? SettingsViewController {
//                dest.fromUnitLabelPass = topLabel.text
//                dest.toUnitLabelPass = bottomLabel.text
//                dest.modePass = mode
//            }
            
            if let bringBackTopLabel = topLabel.text {
                passTopLabel = bringBackTopLabel
            }
            if let bringBackBottomLabel = bottomLabel.text {
                passBottomLabel = bringBackBottomLabel
            }
            
            if mode == "length"{
                passMode = "length"
            } else {
                passMode = "volume"
            }
            
        }
    }
    
    //function for unwinding
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
        if segue.source is SettingsViewController {
            if let senderVC = segue.source as? SettingsViewController {
                topLabel.text = senderVC.passToMainTopLabel
                bottomLabel.text = senderVC.passtoMainBottomLabel
                modePass = senderVC.passToMainMode
                titleAppLabel.text = senderVC.passTitle
            }
        }
    }

    //Dismisses the keyboard when tapped anywhere else
    @IBAction func dismissKeyboardTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    //When the clear button is tapped
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        topTextField.text = nil
        bottomTextField.text = nil
        self.view.endEditing(true)
    }
    
    //when the mode button is clicked
    @IBAction func modeButtonClicked(_ sender: UIButton) {
        if titleAppLabel.text == "Length Conversion Calculator" {
            titleAppLabel.text = "Volume Conversion Calculator"
            topLabel.text = "Gallons"
            bottomLabel.text = "Liters"
            mode = "volume"
            topTextField.text = nil
            bottomTextField.text = nil
            self.view.endEditing(true)
            
        } else {
            titleAppLabel.text = "Length Conversion Calculator"
            topLabel.text = "Yards"
            bottomLabel.text = "Meters"
            mode = "length"
            topTextField.text = nil
            bottomTextField.text = nil
            self.view.endEditing(true)
            
        }
    }
    //When settings button is pressed
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "segueToSettings", sender: self)
    }
    
    //when the calculate button is pressed
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        if topTextField.text! != "" {
            self.bottomTextField.text! = calculation(fromUnit: topLabel.text!, toUnit: bottomLabel.text!, input: topTextField.text!)
        }
        if bottomTextField.text! != "" {
            self.topTextField.text! = calculation(fromUnit: topLabel.text!, toUnit: bottomLabel.text!, input: bottomTextField.text!)
        }
         self.view.endEditing(true)
    
    }
    
    //function to calculate between different units
    func calculation(fromUnit: String, toUnit: String, input: String) -> String {
        var numOutput: Double = 0.00
        
        //calculating the lengths from Yards to other unit
        if fromUnit == "Yards" {
            if toUnit == "Yards" {
                return input
            }
            else if toUnit == "Meters" {
                numOutput = Double(input)! * 0.9144
                return String(numOutput)
            } else {
                numOutput = Double(input)! * 0.000568182
                return String(numOutput)
            }
        }
        if fromUnit == "Meters" {
            if toUnit == "Meters" {
                return input
            } else if toUnit == "Yards" {
                numOutput = Double(input)! * 1.09361
                return String(numOutput)
            } else {
                numOutput = Double(input)! * 0.000621371
                return String(numOutput)
            }
        }
        if fromUnit == "Miles" {
            if toUnit == "Miles" {
                return input
            } else if toUnit == "Yards" {
                numOutput = Double(input)! * 1760.0
                return String(numOutput)
            } else {
                numOutput = Double(input)! * 1609.34
                return String(numOutput)
            }
        }
        
        //calculating volumes
        if fromUnit == "Liters" {
            if toUnit == "Liters" {
                return input
            } else if toUnit == "Gallons" {
                numOutput = Double(input)! * 0.264172
                return String(numOutput)
            } else {
                numOutput = Double(input)! * 1.05669
                return String(numOutput)
            }
        }
        
        if fromUnit == "Gallons" {
            if toUnit == "Gallons" {
                return input
            } else if toUnit == "Liters" {
                numOutput = Double(input)! * 3.78541
                return String(numOutput)
            } else {
                numOutput = Double(input)! * 4.0
                return String(numOutput)
            }
        }
        
        if fromUnit == "Quarts" {
            if toUnit == "Quarts" {
                return input
            } else if toUnit == "Gallons" {
                numOutput = Double(input)! * 0.25
                return String(numOutput)
            } else {
                numOutput = Double(input)! * 0.946353
                return String(numOutput)
            }
        }
        return "Error"
    }
}


extension MainViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.topTextField {
            bottomTextField.text = nil
        } else {
            topTextField.text = nil
        }
    }
    
}


