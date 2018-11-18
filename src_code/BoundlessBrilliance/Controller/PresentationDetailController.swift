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
    let stickerOptions = ["", "yes", "no"]
    let shirtOptions = ["", "yes", "no"]
    var shirtSizes = ["", "extra-small", "small", "medium", "large", "extra-large"]
    //semester
    
    //elementary school/organization
    
    //date
    
    //teacher
    
    //presenter 1
    let Teacher: UITextView! = {
        let tf = UITextView()
        tf.textColor = UIColor.white
        tf.text = "Ms. Crabapple"
        tf.isEditable = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = NSTextAlignment.center
        tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return tf
    }()
    
    //presenter 2
    
    //grade
    let Grade: UITextView! = {
        let gf = UITextView()
        gf.textColor = UIColor.white
        gf.text = "Grade: 3"
        gf.isEditable = false
        gf.translatesAutoresizingMaskIntoConstraints = false
        gf.textAlignment = NSTextAlignment.center
        gf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return gf
    }()
    
    //number of students
    let NumStudents: UITextField! = {
        let ns = UITextField()
        ns.textColor = UIColor.white
        ns.text = "# students?"
        ns.translatesAutoresizingMaskIntoConstraints = false
        ns.textAlignment = NSTextAlignment.center
        ns.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return ns
    }()
    
    //classroom #
    let RoomNum: UITextView! = {
        let rn = UITextView()
        rn.textColor = UIColor.white
        rn.text = "32"
        rn.isEditable = false
        rn.translatesAutoresizingMaskIntoConstraints = false
        rn.textAlignment = NSTextAlignment.center
        rn.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return rn
    }()
    
    //teacher email
    let TeacherEmail: UITextView! = {
        let te = UITextView()
        te.textColor = UIColor.white
        te.text = "mscrabapple@gmail.com"
        te.isEditable = false
        te.translatesAutoresizingMaskIntoConstraints = false
        te.textAlignment = NSTextAlignment.center
        te.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return te
    }()
    
    //presenter 1 email
    let Pres1Email: UITextView! = {
        let p1e = UITextView()
        p1e.textColor = UIColor.white
        p1e.text = "pres1@gmail.com"
        p1e.translatesAutoresizingMaskIntoConstraints = false
        p1e.isEditable = false
        p1e.textAlignment = NSTextAlignment.center
        p1e.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return p1e
    }()
    
    //presenter 2 email
    let Pres2Email: UITextView! = {
        let p2e = UITextView()
        p2e.textColor = UIColor.white
        p2e.text = "pres2@gmail.com"
        p2e.translatesAutoresizingMaskIntoConstraints = false
        p2e.isEditable = false
        p2e.textAlignment = NSTextAlignment.center
        p2e.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return p2e
    }()
    
    //science experiment performed
    let Experiment: UITextField! = {
        let exp = UITextField()
        exp.textColor = UIColor.white
        exp.text = "# students?"
        exp.translatesAutoresizingMaskIntoConstraints = false
        exp.textAlignment = NSTextAlignment.center
        exp.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return exp
    }()
    
    //outreach coordinator
    let OutreachCoordinator: UITextView! = {
        let oc = UITextView()
        oc.textColor = UIColor.white
        oc.text = "Outreach Coordinator"
        oc.translatesAutoresizingMaskIntoConstraints = false
        oc.isEditable = false
        oc.textAlignment = NSTextAlignment.center
        oc.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return oc
    }()
    
    //outreach coordinator email
    let OutreachCoordinatorEmail: UITextView! = {
        let oce = UITextView()
        oce.textColor = UIColor.white
        oce.text = "OC@gmail.com"
        oce.translatesAutoresizingMaskIntoConstraints = false
        oce.isEditable = false
        oce.textAlignment = NSTextAlignment.center
        oce.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return oce
    }()
    
    //time
    let Time: UITextView! = {
        let t = UITextView()
        t.textColor = UIColor.white
        t.text = "14:00"
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isEditable = false
        t.textAlignment = NSTextAlignment.center
        t.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return t
    }()
    
    //transportation
    
    //stickers yes/no
    let StickerDropdown: UITextField! = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        tf.placeholder = "Sticker?"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = NSTextAlignment.center
        tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return tf
    }()
    
    // t-shirt yes/no ? size
    let ShirtDropdown: UITextField! = {
        let tf = UITextField()
        tf.textColor = UIColor.white
        tf.placeholder = "T-Shirt?"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = NSTextAlignment.center
        tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return tf
    }()
    
    // t-shirt yes/no ? size
    let ShirtSizeDropdown: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Shirt Size"
        tf.textAlignment = NSTextAlignment.center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return tf
    }()
    
    
    // subview - nameTextField
    let TestTextField: UITextView = {
        let test_tf = UITextView()
        test_tf.text = "Presentation Details"
        test_tf.textAlignment = NSTextAlignment.center
        test_tf.isEditable = false
        test_tf.textColor = UIColor.white
        
        test_tf.resignFirstResponder()
        test_tf.translatesAutoresizingMaskIntoConstraints = false
        test_tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return test_tf
    }()
    
    // subview - nameTextField
    let LocField: UITextView = {
        let loc_tf = UITextView()
        loc_tf.text = "Location"
        loc_tf.textAlignment = NSTextAlignment.center
        loc_tf.textColor = UIColor.white
        loc_tf.isEditable = false
        loc_tf.resignFirstResponder()
        loc_tf.translatesAutoresizingMaskIntoConstraints = false
        loc_tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return loc_tf
    }()

    // subview - nameTextField
    let NamesField: UITextView = {
        let names_tf = UITextView()
        names_tf.isEditable = false
        names_tf.textAlignment = NSTextAlignment.center
        names_tf.text = "Presenter Names"
        names_tf.resignFirstResponder()
        names_tf.textColor = UIColor.white
        names_tf.translatesAutoresizingMaskIntoConstraints = false
        names_tf.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        return names_tf
    }()
    
    let AnecdoteView: UITextView = {
        let af_tv = UITextView()
        af_tv.text = "Any anecdotes to share?"
        af_tv.textColor = UIColor.white
        af_tv.translatesAutoresizingMaskIntoConstraints = false
        af_tv.backgroundColor = UIColor(r: 120, g: 120, b: 120)
        af_tv.isEditable = true
        return af_tv
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
        setupInputsView(inputsView: inputsView, textField: TestTextField, locField: LocField, namesField: NamesField, anecdoteField: AnecdoteView)
        StickerDropdown?.loadStickerShirtOptions(spinnerOptions: stickerOptions)
        ShirtDropdown?.loadStickerShirtOptions(spinnerOptions: shirtOptions)
        ShirtSizeDropdown?.loadStickerShirtOptions(spinnerOptions: shirtSizes)
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        
    }
    
    func textViewDidChange(_ textView: UITextView){
        if(textView == ShirtDropdown){
            if(textView.text == "yes"){
                shirtSizes =  ["", "extra-small", "small", "medium", "large", "extra-large"]
                ShirtSizeDropdown.backgroundColor = UIColor.black
                ShirtSizeDropdown.textColor = UIColor.black
            }
            else if(textView.text == "no"){
                shirtSizes = [""]
                ShirtSizeDropdown.allowsEditingTextAttributes = false
                ShirtSizeDropdown.backgroundColor = UIColor.gray
                ShirtSizeDropdown.textColor = UIColor.gray
            }
        }
    }
    
    

    func setupInputsView(inputsView: UIScrollView, textField: UITextView, locField: UITextView, namesField: UITextView, anecdoteField: UITextView){
        /* inputsView: need x, y, width, height contraints */
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 4/5).isActive = true
        
        inputsView.addSubview(textField)
        inputsView.addSubview(locField)
        inputsView.addSubview(namesField)
        inputsView.addSubview(anecdoteField)
        inputsView.addSubview(StickerDropdown)
        inputsView.addSubview(ShirtDropdown)
        inputsView.addSubview(ShirtSizeDropdown)
        inputsView.addSubview(Teacher) //
        inputsView.addSubview(Grade)
        inputsView.addSubview(NumStudents)
        inputsView.addSubview(RoomNum) //
        inputsView.addSubview(TeacherEmail) //
        inputsView.addSubview(Pres1Email)
        inputsView.addSubview(Pres2Email)
        inputsView.addSubview(Experiment)
        inputsView.addSubview(OutreachCoordinator)
        inputsView.addSubview(OutreachCoordinatorEmail)
        inputsView.addSubview(Time)
        
        // nameTextField: need x, y, width, height contraints
        textField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        textField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true // 1/4 of entire height
        
        locField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15).isActive = true
        locField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        locField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        Time.topAnchor.constraint(equalTo: locField.bottomAnchor, constant: 15).isActive = true
        Time.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        Time.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        RoomNum.topAnchor.constraint(equalTo: Time.bottomAnchor, constant: 15).isActive = true
        RoomNum.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        RoomNum.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        Teacher.topAnchor.constraint(equalTo: RoomNum.bottomAnchor, constant: 15).isActive = true
        Teacher.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        Teacher.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        TeacherEmail.topAnchor.constraint(equalTo: Teacher.bottomAnchor, constant: 15).isActive = true
        TeacherEmail.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        TeacherEmail.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        NumStudents.topAnchor.constraint(equalTo: TeacherEmail.bottomAnchor, constant: 15).isActive = true
        NumStudents.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        NumStudents.heightAnchor.constraint(equalToConstant: 40).isActive = true
        NumStudents.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 15).isActive = true
        
        Grade.topAnchor.constraint(equalTo: TeacherEmail.bottomAnchor, constant: 15).isActive = true
        Grade.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        Grade.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Grade.leftAnchor.constraint(equalTo: NumStudents.rightAnchor, constant: 15).isActive = true
        
        Experiment.topAnchor.constraint(equalTo: Grade.bottomAnchor, constant: 15).isActive = true
        Experiment.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        Experiment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        namesField.topAnchor.constraint(equalTo: Experiment.bottomAnchor, constant: 15).isActive = true
        namesField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        namesField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        Pres1Email.topAnchor.constraint(equalTo: NamesField.bottomAnchor, constant: 15).isActive = true
        Pres1Email.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        Pres1Email.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        Pres2Email.topAnchor.constraint(equalTo: Pres1Email.bottomAnchor, constant: 15).isActive = true
        Pres2Email.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        Pres2Email.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        OutreachCoordinator.topAnchor.constraint(equalTo: Pres2Email.bottomAnchor, constant: 15).isActive = true
        OutreachCoordinator.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        OutreachCoordinator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        OutreachCoordinatorEmail.topAnchor.constraint(equalTo: OutreachCoordinator.bottomAnchor, constant: 15).isActive = true
        OutreachCoordinatorEmail.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        OutreachCoordinatorEmail.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        anecdoteField.topAnchor.constraint(equalTo: OutreachCoordinatorEmail.bottomAnchor, constant: 15).isActive = true
        anecdoteField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        anecdoteField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        StickerDropdown.topAnchor.constraint(equalTo: anecdoteField.bottomAnchor, constant: 15).isActive = true
        StickerDropdown.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        StickerDropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        ShirtDropdown.topAnchor.constraint(equalTo: StickerDropdown.bottomAnchor).isActive = true
        ShirtDropdown.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 15).isActive = true
        ShirtDropdown.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        ShirtDropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        ShirtSizeDropdown.topAnchor.constraint(equalTo: StickerDropdown.bottomAnchor).isActive = true
        ShirtSizeDropdown.leftAnchor.constraint(equalTo: ShirtDropdown.rightAnchor, constant: 15).isActive = true
        ShirtSizeDropdown.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        ShirtSizeDropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    // Make originally black status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle { get { return .lightContent } }

    
    
}

