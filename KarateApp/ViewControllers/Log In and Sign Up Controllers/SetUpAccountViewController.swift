//
//  SetUpAccountViewController.swift
//  KarateApp
//
//  Created by Vinesh Mistry on 05/04/2018.
//  Copyright © 2018 Vinesh Mistry. All rights reserved.
//

import UIKit
import Firebase
class SetUpAccountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let gradesArray = ["White", "Red", "Yellow", "Orange", "Green", "Blue", "Purple", "Brown (3rd kyu)", "Brown (2nd kyu)", "Brown (1st kyu)", "Black (1st Dan)", "Black (2nd Dan)","Black (3rd Dan)","Black (4th Dan)","Black (5th Dan)","Black (6th Dan)", "Black (7th Dan)"]
    
    var selectedValue : String = ""
    
    @IBOutlet weak var gradePicker: UIPickerView!
    
    @IBOutlet weak var instructorSwitch: UISwitch!
    
    @IBOutlet weak var instructorLabel: UILabel!
    
    let ref = Database.database().reference()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        gradePicker.delegate = self
        gradePicker.dataSource = self
        instructorSwitch.isUserInteractionEnabled = false
        instructorSwitch.isOn = false
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradesArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(row >= 10){
            instructorSwitch.isUserInteractionEnabled = true
        }
        else{
            instructorSwitch.isUserInteractionEnabled = false
            instructorSwitch.isOn = false
        }
        return gradesArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = gradesArray[gradePicker.selectedRow(inComponent: component)]
        print(selectedValue)
    }
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        var userID : String
        if Auth.auth().currentUser != nil {
            userID = (Auth.auth().currentUser?.uid)!
        }
        else {
             userID = "incorrect"
        }
        let instructor = instructorSwitch.isOn
        self.ref.child("users").child(userID).updateChildValues(["grade": selectedValue])
        self.ref.child("users").child(userID).updateChildValues(["instructor": instructor])
        performSegue(withIdentifier: "finishSetUp", sender: self)
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
