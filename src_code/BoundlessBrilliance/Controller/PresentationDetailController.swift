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
    let ScrollViewHeight = 1500
    let stickerOptions = ["", "yes", "no"]
    let shirtOptions = ["", "yes", "no"]
    var shirtSizes = ["", "extra-small", "small", "medium", "large", "extra-large"]
    //semester
    
    //elementary school/organization
    
    //date
    
    let TeacherTitle: UITextView! = {
        let tf = UITextView()
        
        tf.textColor = UIColor.black
        tf.text = "Teacher: "
        tf.isEditable = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = NSTextAlignment.left
        tf.backgroundColor = UIColor.white
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return tf
    }()
    
    //teacher
    let Teacher: UITextView! = {
        let tf = UITextView()
        tf.textColor = UIColor.black
        tf.text = "Ms. Crabapple"
        tf.isEditable = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = NSTextAlignment.right
        tf.backgroundColor = UIColor.white
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return tf
    }()
    
    //presenter 2
    
    //grade
    let Grade: UITextView! = {
        let gf = UITextView()
        gf.textColor = UIColor.black
        gf.text = "Grade: 3"
        gf.isEditable = false
        gf.translatesAutoresizingMaskIntoConstraints = false
        gf.textAlignment = NSTextAlignment.center
        gf.backgroundColor = UIColor.white
        gf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return gf
    }()
    
    //number of students
    let NumStudents: UITextField! = {
        let ns = UITextField()
        ns.textColor = UIColor.black
        ns.placeholder = "# students?"
        ns.translatesAutoresizingMaskIntoConstraints = false
        ns.textAlignment = NSTextAlignment.center
        ns.backgroundColor = UIColor.white
        ns.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return ns
    }()
    
    let RoomNumTitle: UITextView! = {
        let rn = UITextView()
        rn.textColor = UIColor.black
        rn.text = "Room Number: "
        rn.isEditable = false
        rn.translatesAutoresizingMaskIntoConstraints = false
        rn.textAlignment = NSTextAlignment.left
        rn.backgroundColor = UIColor.white
        rn.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return rn
    }()
    
    //classroom #
    let RoomNum: UITextView! = {
        let rn = UITextView()
        rn.textColor = UIColor.black
        rn.text = "32"
        rn.isEditable = false
        rn.translatesAutoresizingMaskIntoConstraints = false
        rn.textAlignment = NSTextAlignment.right
        rn.backgroundColor = UIColor.white
        rn.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return rn
    }()
    
    
    
    //teacher email
    let TeacherEmail: UITextView! = {
        let te = UITextView()
        te.textColor = UIColor.black
        te.text = "mscrabapple@gmail.com"
        te.isEditable = false
        te.translatesAutoresizingMaskIntoConstraints = false
        te.textAlignment = NSTextAlignment.right
        te.backgroundColor = UIColor.white
        te.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return te
    }()
    
    //presenter 1 email
    let Pres1Email: UITextView! = {
        let p1e = UITextView()
        p1e.textColor = UIColor.black
        p1e.text = "pres1@gmail.com"
        p1e.translatesAutoresizingMaskIntoConstraints = false
        p1e.isEditable = false
        p1e.textAlignment = NSTextAlignment.right
        p1e.backgroundColor = UIColor.white
        p1e.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return p1e
    }()
    
    //presenter 2 email
    let Pres2Email: UITextView! = {
        let p2e = UITextView()
        p2e.textColor = UIColor.black
        p2e.text = "pres2@gmail.com"
        p2e.translatesAutoresizingMaskIntoConstraints = false
        p2e.isEditable = false
        p2e.textAlignment = NSTextAlignment.right
        p2e.backgroundColor = UIColor.white
        p2e.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return p2e
    }()
    
    //science experiment performed
    let Experiment: UITextField! = {
        let exp = UITextField()
        exp.textColor = UIColor.black
        exp.text = "Experiment Performed"
        exp.translatesAutoresizingMaskIntoConstraints = false
        exp.textAlignment = NSTextAlignment.right
        exp.backgroundColor = UIColor.white
        exp.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return exp
    }()
    
    let OCTitle: UITextView! = {
        let oc = UITextView()
        oc.textColor = UIColor.black
        oc.text = "Outreach Coordinator: "
        oc.translatesAutoresizingMaskIntoConstraints = false
        oc.isEditable = false
        oc.textAlignment = NSTextAlignment.left
        oc.backgroundColor = UIColor.white
        oc.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return oc
    }()
    
    //outreach coordinator
    let OutreachCoordinator: UITextView! = {
        let oc = UITextView()
        oc.textColor = UIColor.black
        oc.text = "Audrey Shawley"
        oc.translatesAutoresizingMaskIntoConstraints = false
        oc.isEditable = false
        oc.textAlignment = NSTextAlignment.right
        oc.backgroundColor = UIColor.white
        oc.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return oc
    }()
    
    //outreach coordinator email
    let OutreachCoordinatorEmail: UITextView! = {
        let oce = UITextView()
        oce.textColor = UIColor.black
        oce.text = "OC@gmail.com"
        oce.translatesAutoresizingMaskIntoConstraints = false
        oce.isEditable = false
        oce.textAlignment = NSTextAlignment.right
        oce.backgroundColor = UIColor.white
        oce.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return oce
    }()
    
    let TimeTitle: UITextView! = {
        let t = UITextView()
        t.textColor = UIColor.black
        t.text = "Time: "
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isEditable = false
        t.textAlignment = NSTextAlignment.left
        t.backgroundColor = UIColor.white
        t.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return t
    }()
    
    //time
    let Time: UITextView! = {
        let t = UITextView()
        t.textColor = UIColor.black
        t.text = "14:00"
        t.translatesAutoresizingMaskIntoConstraints = false
        t.isEditable = false
        t.textAlignment = NSTextAlignment.right
        t.backgroundColor = UIColor.white
        t.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return t
    }()
    
    //transportation
    
    
    //stickers yes/no
    let StickerDropdown: UITextField! = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.placeholder = "Sticker?"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = NSTextAlignment.center
        tf.backgroundColor = UIColor.white
        tf.borderStyle = UITextField.BorderStyle.line
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return tf
    }()
    
    // t-shirt yes/no ? size
    let ShirtDropdown: UITextField! = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.placeholder = "T-Shirt?"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = NSTextAlignment.center
        tf.backgroundColor = UIColor.white
        tf.borderStyle = UITextField.BorderStyle.line
//        tf.borderStyle
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return tf
    }()
    
    // t-shirt yes/no ? size
    let ShirtSizeDropdown: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Shirt Size"
        tf.textAlignment = NSTextAlignment.center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.white
        tf.borderStyle = UITextField.BorderStyle.line
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
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
        test_tf.backgroundColor = UIColor.white
        test_tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return test_tf
    }()
    
    let LocFieldTitle: UITextView! = {
        let loc_tf = UITextView()
        loc_tf.text = "Location:"
        loc_tf.textAlignment = NSTextAlignment.left
        loc_tf.textColor = UIColor.black
        loc_tf.isEditable = false
        loc_tf.resignFirstResponder()
        loc_tf.translatesAutoresizingMaskIntoConstraints = false
        loc_tf.backgroundColor = UIColor.white
        loc_tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return loc_tf
    }()
    
    // subview - nameTextField
    let LocField: UITextView = {
        let loc_tf = UITextView()
        loc_tf.text = "Bayview Elementary"
        loc_tf.textAlignment = NSTextAlignment.right
        loc_tf.textColor = UIColor.black
        loc_tf.isEditable = false
        loc_tf.resignFirstResponder()
        loc_tf.translatesAutoresizingMaskIntoConstraints = false
        loc_tf.backgroundColor = UIColor.white
        loc_tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return loc_tf
    }()

    let NamesFieldTitle: UITextView = {
        let names_tf = UITextView()
        names_tf.isEditable = false
        names_tf.textAlignment = NSTextAlignment.left
        names_tf.text = "Presenters:"
        names_tf.resignFirstResponder()
        names_tf.textColor = UIColor.black
        names_tf.translatesAutoresizingMaskIntoConstraints = false
        names_tf.backgroundColor = UIColor.white
        names_tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return names_tf
    }()
    
    // subview - nameTextField
    let NamesField: UITextView = {
        let names_tf = UITextView()
        names_tf.isEditable = false
        names_tf.textAlignment = NSTextAlignment.right
        names_tf.text = "Presenters: "
        names_tf.resignFirstResponder()
        names_tf.textColor = UIColor.black
        names_tf.translatesAutoresizingMaskIntoConstraints = false
        names_tf.backgroundColor = UIColor.white
        names_tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return names_tf
    }()
    
    let AnecdoteView: UITextView = {
        let af_tv = UITextView()
        af_tv.text = "Any anecdotes to share?"
        af_tv.textColor = UIColor.black
        af_tv.translatesAutoresizingMaskIntoConstraints = false
        af_tv.backgroundColor = UIColor.white
        af_tv.isEditable = true
        af_tv.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return af_tv
    }()
    
        public lazy var leaveInputButton: UIButton = {
            $0.backgroundColor = UIColor(r: 0, g: 128, b: 128)
            $0.setTitle("Post-pres Survey", for: .normal)
            // must set up this property otherwise, the specified anchors will not work
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitleColor(UIColor.white, for: .normal)
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            $0.layer.cornerRadius = 5
            $0.addTarget(self, action: #selector(enterSurvey), for: .touchUpInside)
            return $0
        }(UIButton())
    
//    end examples from the alerts and pickers app cell file-----------------------------
    
        @objc func enterSurvey() {
    
            //        let presentationListVC = PresentationListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
            //        self.present(presentationListVC, animated: true)
            let surveyController = SurveyController()
            surveyController.presentation = presentation
            super.navigationController?.pushViewController(surveyController, animated: true)
    
        }
    
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
        inputsView.addSubview(LocFieldTitle)
        inputsView.addSubview(locField)
        
        let separator1 = UIView()
        initSeparator(separator: separator1)
        inputsView.addSubview(separator1)
        setupSeparator(emailSeparatorView: separator1, inputsView: inputsView, aboveView: LocFieldTitle)
        
        inputsView.addSubview(TimeTitle)
        inputsView.addSubview(Time)
        
        let separator2 = UIView()
        initSeparator(separator: separator2)
        inputsView.addSubview(separator2)
        setupSeparator(emailSeparatorView: separator2, inputsView: inputsView, aboveView: TimeTitle)
        
        inputsView.addSubview(RoomNumTitle)
        inputsView.addSubview(RoomNum) //
        
        let separator3 = UIView()
        initSeparator(separator: separator3)
        inputsView.addSubview(separator3)
        setupSeparator(emailSeparatorView: separator3, inputsView: inputsView, aboveView: RoomNumTitle)
        
        inputsView.addSubview(TeacherTitle)
        inputsView.addSubview(Teacher) //
        inputsView.addSubview(TeacherEmail) //
        
        let separator4 = UIView()
        initSeparator(separator: separator4)
        inputsView.addSubview(separator4)
        setupSeparator(emailSeparatorView: separator4, inputsView: inputsView, aboveView: TeacherEmail)

        inputsView.addSubview(Grade)
        inputsView.addSubview(NumStudents)
        
        let separator5 = UIView()
        initSeparator(separator: separator5)
        inputsView.addSubview(separator5)
        setupSeparator(emailSeparatorView: separator5, inputsView: inputsView, aboveView: Grade)
        
        inputsView.addSubview(Experiment)
        
        let separator6 = UIView()
        initSeparator(separator: separator6)
        inputsView.addSubview(separator6)
        setupSeparator(emailSeparatorView: separator6, inputsView: inputsView, aboveView: Experiment)
        
        inputsView.addSubview(NamesFieldTitle)
        inputsView.addSubview(namesField)
        inputsView.addSubview(Pres1Email)
        inputsView.addSubview(Pres2Email)
        
        let separator7 = UIView()
        initSeparator(separator: separator7)
        inputsView.addSubview(separator7)
        setupSeparator(emailSeparatorView: separator7, inputsView: inputsView, aboveView: Pres2Email)
        
        inputsView.addSubview(OCTitle)
        inputsView.addSubview(OutreachCoordinator)
        inputsView.addSubview(OutreachCoordinatorEmail)
        
        let separator8 = UIView()
        initSeparator(separator: separator8)
        inputsView.addSubview(separator8)
        setupSeparator(emailSeparatorView: separator8, inputsView: inputsView, aboveView: OutreachCoordinatorEmail)
        
        inputsView.addSubview(anecdoteField)
       
        inputsView.addSubview(leaveInputButton)
        
        let separatorLeft = UIView()
        initSeparator(separator: separatorLeft)
        inputsView.addSubview(separatorLeft)
        setupVertLeftSeparator(emailSeparatorView: separatorLeft, inputsView: inputsView, aboveView: OutreachCoordinatorEmail, sideView: anecdoteField)
        
        let separatorRight = UIView()
        initSeparator(separator: separatorRight)
        inputsView.addSubview(separatorRight)
        setupVertRightSeparator(emailSeparatorView: separatorRight, inputsView: inputsView, aboveView: OutreachCoordinatorEmail, sideView: anecdoteField, otherSeparator: separator8)
        
        let separator9 = UIView()
        initSeparator(separator: separator9)
        inputsView.addSubview(separator9)
        setupSeparator(emailSeparatorView: separator9, inputsView: inputsView, aboveView: anecdoteField)
        
        inputsView.addSubview(StickerDropdown)
        inputsView.addSubview(ShirtDropdown)
        inputsView.addSubview(ShirtSizeDropdown)
        
        let bottomBorder = CALayer ()
        bottomBorder.frame = CGRect(x: 0.0, y: 43.0, width: inputsView.frame.width, height: 1.0)
        bottomBorder.backgroundColor = UIColor.gray.cgColor
        
        textField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        textField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true // 1/4 of entire height
        
        LocFieldTitle.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15).isActive = true
        LocFieldTitle.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/3).isActive = true
        LocFieldTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        LocFieldTitle.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        
        locField.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15).isActive = true
        locField.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 2/3).isActive = true
        locField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        locField.leftAnchor.constraint(equalTo: LocFieldTitle.rightAnchor).isActive = true
        
        TimeTitle.topAnchor.constraint(equalTo: locField.bottomAnchor, constant: 6).isActive = true
        TimeTitle.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        TimeTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TimeTitle.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        
        Time.topAnchor.constraint(equalTo: locField.bottomAnchor, constant: 6).isActive = true
        Time.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        Time.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Time.leftAnchor.constraint(equalTo: TimeTitle.rightAnchor).isActive = true
        
        RoomNumTitle.topAnchor.constraint(equalTo: Time.bottomAnchor, constant: 6).isActive = true
        RoomNumTitle.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        RoomNumTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        RoomNumTitle.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        
        RoomNum.topAnchor.constraint(equalTo: Time.bottomAnchor, constant: 6).isActive = true
        RoomNum.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        RoomNum.heightAnchor.constraint(equalToConstant: 40).isActive = true
        RoomNum.leftAnchor.constraint(equalTo: RoomNumTitle.rightAnchor).isActive = true
       
        TeacherTitle.topAnchor.constraint(equalTo: RoomNum.bottomAnchor, constant: 6).isActive = true
        TeacherTitle.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        TeacherTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        TeacherTitle.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        
        Teacher.topAnchor.constraint(equalTo: RoomNumTitle.bottomAnchor, constant: 6).isActive = true
        Teacher.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        Teacher.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Teacher.leftAnchor.constraint(equalTo: TeacherTitle.rightAnchor).isActive = true
        
        TeacherEmail.topAnchor.constraint(equalTo: Teacher.bottomAnchor, constant: 6).isActive = true
        TeacherEmail.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        TeacherEmail.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        NumStudents.topAnchor.constraint(equalTo: TeacherEmail.bottomAnchor, constant: 6).isActive = true
        NumStudents.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        NumStudents.heightAnchor.constraint(equalToConstant: 40).isActive = true
        NumStudents.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 15).isActive = true
        
        Grade.topAnchor.constraint(equalTo: TeacherEmail.bottomAnchor, constant: 6).isActive = true
        Grade.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        Grade.heightAnchor.constraint(equalToConstant: 40).isActive = true
        Grade.leftAnchor.constraint(equalTo: NumStudents.rightAnchor, constant: 15).isActive = true
        
        Experiment.topAnchor.constraint(equalTo: Grade.bottomAnchor, constant: 6).isActive = true
        Experiment.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        Experiment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        NamesFieldTitle.topAnchor.constraint(equalTo: Experiment.bottomAnchor, constant: 6).isActive = true
        NamesFieldTitle.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        NamesFieldTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        NamesFieldTitle.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        
        namesField.topAnchor.constraint(equalTo: Experiment.bottomAnchor, constant: 6).isActive = true
        namesField.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        namesField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        namesField.leftAnchor.constraint(equalTo: NamesFieldTitle.rightAnchor).isActive = true
        
        Pres1Email.topAnchor.constraint(equalTo: NamesField.bottomAnchor, constant: 6).isActive = true
        Pres1Email.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        Pres1Email.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        Pres2Email.topAnchor.constraint(equalTo: Pres1Email.bottomAnchor).isActive = true
        Pres2Email.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        Pres2Email.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        OCTitle.topAnchor.constraint(equalTo: Pres2Email.bottomAnchor, constant: 6).isActive = true
        OCTitle.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        OCTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        OCTitle.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        
        OutreachCoordinator.topAnchor.constraint(equalTo: Pres2Email.bottomAnchor, constant: 6).isActive = true
        OutreachCoordinator.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        OutreachCoordinator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        OutreachCoordinator.leftAnchor.constraint(equalTo: OCTitle.rightAnchor).isActive = true
        
        OutreachCoordinatorEmail.topAnchor.constraint(equalTo: OutreachCoordinator.bottomAnchor).isActive = true
        OutreachCoordinatorEmail.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        OutreachCoordinatorEmail.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        anecdoteField.topAnchor.constraint(equalTo: OutreachCoordinatorEmail.bottomAnchor, constant: 6).isActive = true
        anecdoteField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 2).isActive = true
        anecdoteField.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -10).isActive = true
        anecdoteField.heightAnchor.constraint(equalToConstant: 200).isActive = true
        drawRect(startx: anecdoteField.frame.minX, starty: anecdoteField.frame.minY, endx: anecdoteField.frame.maxX, endy: anecdoteField.frame.maxY)
        
        
        StickerDropdown.topAnchor.constraint(equalTo: anecdoteField.bottomAnchor, constant: 6).isActive = true
        StickerDropdown.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        StickerDropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        ShirtDropdown.topAnchor.constraint(equalTo: StickerDropdown.bottomAnchor, constant: 6).isActive = true
        ShirtDropdown.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 5).isActive = true
        ShirtDropdown.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        ShirtDropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        ShirtSizeDropdown.topAnchor.constraint(equalTo: StickerDropdown.bottomAnchor, constant: 6).isActive = true
        ShirtSizeDropdown.leftAnchor.constraint(equalTo: ShirtDropdown.rightAnchor, constant: 10).isActive = true
        ShirtSizeDropdown.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        ShirtSizeDropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        leaveInputButton.topAnchor.constraint(equalTo: ShirtDropdown.bottomAnchor, constant: 10).isActive = true
        leaveInputButton.leftAnchor.constraint(equalTo: ShirtDropdown.rightAnchor, constant: 10).isActive = true
        leaveInputButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        leaveInputButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        setScrollViewSize(inputsView: inputsView)
    }
    
    func setScrollViewSize(inputsView: UIScrollView){
        var height: CGFloat = 0
        for view in inputsView.subviews {
            print("subview height: \(view.frame.size.height)")
            print("scrollview height: \(height)")
            
            height = height + view.bounds.size.height
        }
        
        inputsView.contentSize = CGSize(width: inputsView.frame.width, height: CGFloat(ScrollViewHeight))
    }
    
    // Make originally black status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle { get { return .lightContent } }

    
//    rect: CGRect,
    func drawRect( startx: CGFloat, starty: CGFloat, endx: CGFloat , endy: CGFloat) {
        let aPath = UIBezierPath()
        
        aPath.move(to: CGPoint(x:/*Put starting Location*/startx, y: starty/*Put starting Location*/))
        
        aPath.addLine(to: CGPoint(x: endx/*Put Next Location*/, y: starty/*Put Next Location*/))
        aPath.addLine(to: CGPoint(x: endx/*Put Next Location*/, y: endy/*Put Next Location*/))
        aPath.addLine(to: CGPoint(x: startx/*Put Next Location*/, y: endy/*Put Next Location*/))
//        aPath.addLine(to: CGPoint(x: endx/*Put Next Location*/, y: starty/*Put Next Location*/))
        //Keep using the method addLineToPoint until you get to the one where about to close the path
        
        aPath.close()
        
        //If you want to stroke it with a red color
        UIColor.red.set()
        aPath.stroke()
        //If you want to fill it as well
//        aPath.fill()
    }
    
    func setupSeparator(emailSeparatorView: UIView, inputsView: UIScrollView, aboveView: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupVertLeftSeparator(emailSeparatorView: UIView, inputsView: UIScrollView, aboveView: UIView, sideView: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func setupVertRightSeparator(emailSeparatorView: UIView, inputsView: UIScrollView, aboveView: UIView, sideView: UIView, otherSeparator: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: sideView.rightAnchor, constant: 7).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func initSeparator(separator: UIView){
        separator.backgroundColor = UIColor.gray
        separator.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

