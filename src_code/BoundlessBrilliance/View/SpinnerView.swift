//
//  DropDownView.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/20/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//
import UIKit

class SpinnerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var spinner_options: [String]!
    var spinner_text_field: UITextField!
    
    // Initializes SpinnerView object
    init(spinnerOptions: [String], spinnerTextField: UITextField) {
        super.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
        self.spinner_options = spinnerOptions
        self.spinner_text_field = spinnerTextField
        
        self.delegate = self
        self.dataSource = self
        
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                if (spinnerOptions.count > 0) {
                    self.spinner_text_field.text = self.spinner_options[0]
                    self.spinner_text_field.isEnabled = true
                } else {
                    self.spinner_text_field = nil
                    self.spinner_text_field.isEnabled = false
                }
            }
        }
        
    }
    
    // Returns error if init(coder: ) has not been implemented
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Set number of columns in pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Set number of rows in pickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return spinner_options.count
    }
    
    // Returns title from row index in spinner_options
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return spinner_options[row]
    }
    
    // Sets text field to choice from optionsList
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        spinner_text_field.text = spinner_options[row]
    }
    
}
