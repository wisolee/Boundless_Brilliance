//
//  CellDetailController.swift
//  BoundlessBrilliance
//
//  Created by Adam on 11/12/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import Foundation
import UIKit

class PresentationDetailController : UIViewController{

    var presentation:PresentationListItemModel? = nil
    
    
    // subview - nameTextField
    let TestTextField: UITextField = {
        let test_tf = UITextField()
        test_tf.text = "Presentation Details"
        test_tf.textAlignment = NSTextAlignment.center
        test_tf.textColor = UIColor.white
        test_tf.translatesAutoresizingMaskIntoConstraints = false
        test_tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return test_tf
    }()
    
    // subview - nameTextField
    let LocField: UITextField = {
        let loc_tf = UITextField()
        loc_tf.text = "Location"
        loc_tf.textAlignment = NSTextAlignment.center
        loc_tf.textColor = UIColor.white
        loc_tf.allowsEditingTextAttributes = false
        loc_tf.translatesAutoresizingMaskIntoConstraints = false
        loc_tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return loc_tf
    }()

    // subview - nameTextField
    let NamesField: UITextField = {
        let names_tf = UITextField()
        names_tf.allowsEditingTextAttributes = false
        names_tf.textAlignment = NSTextAlignment.center
        names_tf.text = "Presenter Names"
        names_tf.textColor = UIColor.white
        names_tf.translatesAutoresizingMaskIntoConstraints = false
        names_tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return names_tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create variables
        let presDetailView  = PresentationDetailView()
        let inputsView = presDetailView.inputsView
    
        /* Add subviews */
        view.addSubview(inputsView)
        LocField.text = presentation?.location
        NamesField.text = presentation?.names
        setupInputsView(inputsView: inputsView, textField: TestTextField, locField: LocField, namesField: NamesField)
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        
    }
    


    func setupInputsView(inputsView: UIView, textField: UITextField, locField: UITextField, namesField: UITextField){
        /* inputsView: need x, y, width, height contraints */
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        inputsView.addSubview(textField)
        inputsView.addSubview(locField)
        inputsView.addSubview(namesField)
        // nameTextField: need x, y, width, height contraints
        textField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        textField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        textField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
        locField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20).isActive = true
        locField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        locField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/5).isActive = true
        
        namesField.topAnchor.constraint(equalTo: locField.bottomAnchor, constant: 20).isActive = true
        namesField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        namesField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/5).isActive = true
    }
    

    
    
}

