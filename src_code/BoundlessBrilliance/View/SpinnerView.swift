//
//  DropDownView.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/20/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//
import UIKit

class SpinnerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    var spinnerOptions: [String]!
    var spinnerTextField: UITextField!
    
    init(spinnerOptions: [String], spinnerTextField: UITextField) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        self.spinnerOptions = spinnerOptions
        self.spinnerTextField = spinnerTextField
        
        self.delegate = self
        self.dataSource = self
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                if (spinnerOptions.count > 0) {
                    self.spinnerTextField.text = self.spinnerOptions[0]
                    self.spinnerTextField.isEnabled = true
                } else {
                    self.spinnerTextField = nil
                    self.spinnerTextField.isEnabled = false
                }
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set number of columns in pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Set number of rows in pickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return spinnerOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return spinnerOptions[row]
    }
    
    // Sets text field to choice from optionsList
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        spinnerTextField.text = spinnerOptions[row]
    }
    
}
