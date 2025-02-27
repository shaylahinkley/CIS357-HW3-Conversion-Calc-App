//
//  SettingsViewController.swift
//  CIS357-HW3
//
//  Created by Shayla Hinkley on 9/26/20.
//  Copyright © 2020 Shayla Hinkley. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var settingsFromUnit: UILabel!
    
    @IBOutlet weak var settingsToUnit: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    var modePass: String?
    var fromUnitLabelPass: String?
    var toUnitLabelPass: String?
    
    var passToMainTopLabel: String!
    var passtoMainBottomLabel: String!
    var passToMainMode: String!
    var passTitle: String!
    
    var mode: String = ""
    
    //String that tells picker which label was touched
    var fromOrTo: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting title to settings
        self.title = "Settings"
        
        
        if let hasFromUnitLabel = self.fromUnitLabelPass {
            self.settingsFromUnit.text = hasFromUnitLabel
        }
        
        if let hasToUnitLabel = self.toUnitLabelPass {
            self.settingsToUnit.text = hasToUnitLabel
        }
        if let mode = self.modePass {
            self.mode =  mode
        }
        
        self.pickerOptions()
        
        //connecting data to picker
        self.picker.delegate = self
        self.picker.dataSource = self
              
        //start with picker hidden
        self.picker.isHidden = true
        
        //setting up tapping feature on the UILabels
        let fromUnitTapped = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.tapFromUnits))
             settingsFromUnit.isUserInteractionEnabled = true
             settingsFromUnit.addGestureRecognizer(fromUnitTapped)
        
        let toUnitTapped = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.tapToUnits))
                    settingsToUnit.isUserInteractionEnabled = true
                    settingsToUnit.addGestureRecognizer(toUnitTapped)
        self.loadData()
    }
    
   func pickerOptions() {
    if self.mode == "length" {
            pickerData = ["Yards", "Meters", "Miles"]
        } else {
            pickerData = ["Gallons", "Quarts", "Liters"]
        }
    }
    
    func loadData() {
        view.reloadInputViews()
    }
    
    //action items for the tapping on different labels
   @IBAction func tapFromUnits(sender: UITapGestureRecognizer){
        self.picker.isHidden = false
        whichOne(fromOrToStr: "fromUnits")
        
   }
    @IBAction func tapToUnits(sender: UITapGestureRecognizer) {
        self.picker.isHidden = false
        whichOne(fromOrToStr: "toUnits")
    }
    
    //helper function to tell picker which label is tapped
    func whichOne(fromOrToStr: String){
           fromOrTo = fromOrToStr
       }

   
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let bringBackTopLabel = settingsFromUnit.text {
            passToMainTopLabel = bringBackTopLabel
        }
        if let bringBackBottomLabel = settingsToUnit.text {
            passtoMainBottomLabel = bringBackBottomLabel
        }
        passToMainMode = mode
        
        if mode == "length" {
            passTitle = "Length Conversion Calculator"
        } else {
            passTitle = "Volume Conversion Calculator"
        }
    }
    
    //dismiss when cancel button is pressed
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    //these methods are for the view picker
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Number of columns for the view picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //number of rows of data (always 3)
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    

    //the data to return for the row that is being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    //sets the rows of the picker view accordingly
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if fromOrTo == "fromUnits" {
            settingsFromUnit.text = pickerData[row]
        } else {
            settingsToUnit.text = pickerData[row]
        }
        picker.reloadAllComponents()
    }
    
    
}
