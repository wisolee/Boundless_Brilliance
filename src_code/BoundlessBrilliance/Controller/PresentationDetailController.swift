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
    let ScrollViewHeight = 750
    let stickerOptions = ["", "yes", "no"]
    let shirtOptions = ["", "yes", "no"]
    var shirtSizes = ["", "extra-small", "small", "medium", "large", "extra-large"]
    
    let TimeTitle: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Time: "
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 20)
        $0.textColor = UIColor(r: 0, g: 163, b: 173)
        return $0
    }(UITextView())
    
    let DateText: UITextView! = {
        $0.text = "2018-12-30"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 30)
        $0.textColor = UIColor(r: 0, g: 163, b: 173)
        return $0
    }(UITextView())
    
    
    //time
    let Time: UITextView! = {
        $0.text = "14:00"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 20)
        $0.textColor = UIColor(r: 0, g: 163, b: 173)
        return $0
    }(UITextView())
    
    let TeacherTitle: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Teacher: "
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //teacher
    let Teacher: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Ms. Crabapple"
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //presenter 2
    
    //grade
    let Grade: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "3"
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //number of students
    let GradeLabel: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Grade:"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    let RoomNumTitle: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Room Number: "
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //classroom #
    let RoomNum: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "32"
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //teacher email
    let TeacherEmail: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "mscrabapple@gmail.com"
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //presenter 1 email
    let Pres1Email: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "pres1@gmail.com"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //presenter 2 email
    let Pres2Email: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "pres2@gmail.com"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    let OCTitle: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Outreach Coordinator: "
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //outreach coordinator
    let OutreachCoordinator: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Audrey Shawley"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //outreach coordinator email
    let OutreachCoordinatorEmail: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "OC@gmail.com"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    //stickers yes/no
    let StickerDropdown: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "Sticker?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.center
        $0.backgroundColor = UIColor.white
        $0.borderStyle = UITextField.BorderStyle.line
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // t-shirt yes/no ? size
    let ShirtDropdown: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "T-Shirt?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.center
        $0.backgroundColor = UIColor.white
        $0.borderStyle = UITextField.BorderStyle.line
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // t-shirt yes/no ? size
    let ShirtSizeDropdown: UITextField! = {
        $0.placeholder = "Shirt Size"
        $0.textAlignment = NSTextAlignment.center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.borderStyle = UITextField.BorderStyle.line
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // subview - nameTextField
//    let TestTextField: UITextView = {
//        $0.text = "Presentation Details"
//        $0.textAlignment = NSTextAlignment.center
//        $0.isEditable = false
//        $0.textColor = UIColor.white
//        $0.resignFirstResponder()
//        $0.translatesAutoresizingMaskIntoConstraints = false
//        $0.backgroundColor = UIColor.white
//        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
//        return $0
//    }(UITextView())
    
    let LocFieldTitle: UITextView! = {
        $0.text = "Location:"
        $0.textAlignment = NSTextAlignment.left
        $0.textColor = UIColor.black
        $0.isEditable = false
        $0.resignFirstResponder()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // subview - nameTextField
    let LocField: UITextView = {
        $0.text = "Bayview Elementary"
        $0.textAlignment = NSTextAlignment.right
        $0.textColor = UIColor.black
        $0.isEditable = false
        $0.resignFirstResponder()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())

    let NamesFieldTitle: UITextView = {
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.left
        $0.text = "Presenters:"
        $0.resignFirstResponder()
        $0.textColor = UIColor.black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // subview - nameTextField
    let NamesField: UITextView = {
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.right
        $0.text = "Presenters:"
        $0.resignFirstResponder()
        $0.textColor = UIColor.black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // subview - nameTextField
    let NamesField1: UITextView = {
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.right
        $0.text = ""
        $0.resignFirstResponder()
        $0.textColor = UIColor.black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // subview - nameTextField
    let NamesField2: UITextView = {
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.right
        $0.text = ""
        $0.resignFirstResponder()
        $0.textColor = UIColor.black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    public lazy var leaveInputButton: UIButton = {
        $0.backgroundColor = UIColor(r: 0, g: 163, b: 173)
        $0.setTitle("Feedback", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.adjustsFontSizeToFitWidth = true
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(enterSurvey), for: .touchUpInside)
        return $0
    }(UIButton())
    
    let inputInfo: UILabel = {
        $0.text = ""
        $0.textAlignment = NSTextAlignment.center
//        $0.isEditable = false
        $0.numberOfLines = 3
        $0.textColor = UIColor.gray
        $0.resignFirstResponder()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: 13)
        return $0
    }(UILabel())
    
    
//    end examples from the alerts and pickers app cell file-----------------------------
    
    @objc func enterSurvey() {
        let surveyController = SurveyController()
        surveyController.presentation = presentation
        super.navigationController?.pushViewController(surveyController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create variables
        let presDetailView  = PresentationDetailView()
        let scrollContainer = presDetailView.scrollContainer
        let inputsView = presDetailView.inputsView
        /* Add subviews */
        view.addSubview(scrollContainer)
        scrollContainer.addSubview(inputsView)
        
        Time.text = parseTime(timeText: (presentation?.time)!)
        DateText.text = parseDate(dateText: (presentation?.date)!)
        LocField.text = presentation?.location
        NamesField.text = presentation?.names
        
//        Teacher.text = presentation?.teacherName
//        TeacherEmail.text = presentation?.teacherEmail
//        Grade.text = presentation?.grade
//        RoomNum.text = presentation?.roomNumber
        parseNames(names: (presentation?.names)!)
        checkDateUpdateButton(button: leaveInputButton)
        setupInputsView(inputsView: inputsView, scrollView: scrollContainer)
        StickerDropdown?.loadStickerShirtOptions(spinnerOptions: stickerOptions)
        ShirtDropdown?.loadStickerShirtOptions(spinnerOptions: shirtOptions)
        ShirtSizeDropdown?.loadStickerShirtOptions(spinnerOptions: shirtSizes)
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
    }
    

    
    
    func setupInputsView(inputsView: UIView, scrollView: UIScrollView){
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        inputsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        inputsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        inputsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        inputsView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        inputsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        inputsView.addSubview(DateText)
        inputsView.addSubview(Time)
        
        inputsView.addSubview(LocFieldTitle)
        inputsView.addSubview(LocField)
        
        let separator1 = UIView()
        initSeparator(separator: separator1)
        inputsView.addSubview(separator1)
        setupSeparator(emailSeparatorView: separator1, inputsView: inputsView, aboveView: LocFieldTitle)
        
        inputsView.addSubview(RoomNumTitle)
        inputsView.addSubview(RoomNum)
        
        let separator3 = UIView()
        initSeparator(separator: separator3)
        inputsView.addSubview(separator3)
        setupSeparator(emailSeparatorView: separator3, inputsView: inputsView, aboveView: RoomNumTitle)
        
        inputsView.addSubview(TeacherTitle)
        inputsView.addSubview(Teacher)
        inputsView.addSubview(TeacherEmail)
        
        let separator4 = UIView()
        initSeparator(separator: separator4)
        inputsView.addSubview(separator4)
        setupSeparator(emailSeparatorView: separator4, inputsView: inputsView, aboveView: TeacherEmail)

        inputsView.addSubview(Grade)
        inputsView.addSubview(GradeLabel)
        
        let separator5 = UIView()
        initSeparator(separator: separator5)
        inputsView.addSubview(separator5)
        setupSeparator(emailSeparatorView: separator5, inputsView: inputsView, aboveView: Grade)
        
        inputsView.addSubview(NamesFieldTitle)
        inputsView.addSubview(NamesField)
        inputsView.addSubview(NamesField1)
        inputsView.addSubview(NamesField2)
        
        let separator7 = UIView()
        initSeparator(separator: separator7)
        inputsView.addSubview(separator7)
        setupSeparator(emailSeparatorView: separator7, inputsView: inputsView, aboveView: NamesField2)
        
        inputsView.addSubview(OCTitle)
        inputsView.addSubview(OutreachCoordinator)
        inputsView.addSubview(OutreachCoordinatorEmail)
        
        inputsView.addSubview(leaveInputButton)
        inputsView.addSubview(inputInfo)
        
        let bottomBorder = CALayer ()
        bottomBorder.frame = CGRect(x: 0.0, y: 43.0, width: inputsView.frame.width, height: 1.0)
        bottomBorder.backgroundColor = UIColor.gray.cgColor

        initWideView(target: DateText, topView: inputsView, container: inputsView)
        DateText.topAnchor.constraint(equalTo: inputsView.topAnchor, constant: 6).isActive = true
        
        initWideView(target: Time, topView: DateText, container: inputsView)
        Time.topAnchor.constraint(equalTo: DateText.bottomAnchor).isActive = true
        
        initFirstSmallLeftView(target: LocFieldTitle, topView: Time, container: inputsView)
       
        initFirstLargeRightView(target: LocField, topView: Time, container: inputsView, leftView: LocFieldTitle)
       // LocField.topAnchor.constraint(equalTo: Time.bottomAnchor, constant: 25).isActive = true
//        LocField.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 2/3).isActive = true
        
        //initSplitLeftView(target: TimeTitle, topView: LocFieldTitle, container: inputsView)
        //initSplitRightView(target: Time, topView: LocFieldTitle, container: inputsView, leftView: TimeTitle)
        
        initSplitLeftView(target: RoomNumTitle, topView: LocFieldTitle, container: inputsView)
        initSplitRightView(target: RoomNum, topView: LocField, container: inputsView, leftView: RoomNumTitle)
       
        initSplitLeftView(target: TeacherTitle, topView: RoomNumTitle, container: inputsView)
        initSplitRightView(target: Teacher, topView: RoomNumTitle, container: inputsView, leftView: TeacherTitle)
        
        initSplitRightViewLessTopPadding(target: TeacherEmail, topView: TeacherTitle, container: inputsView, leftView: TeacherTitle)
        
        initSplitLeftView(target: GradeLabel, topView: TeacherEmail, container: inputsView)
        initSplitRightView(target: Grade, topView: TeacherEmail, container: inputsView, leftView: GradeLabel)
        //Grade.topAnchor.constraint(equalTo: TeacherEmail.bottomAnchor, constant: 25).isActive = true
        
        initSplitLeftView(target: NamesFieldTitle, topView: GradeLabel, container: inputsView)
        initSplitRightView(target: NamesField, topView: GradeLabel, container: inputsView, leftView: NamesFieldTitle)
        initSplitRightViewLessTopPadding(target: NamesField2, topView: NamesField, container: inputsView, leftView: NamesFieldTitle)
        //initSplitRightView(target: NamesField2, topView: NamesField, container: inputsView, leftView: NamesFieldTitle)
        
        initSplitLeftView(target: OCTitle, topView: NamesField2, container: inputsView)
        initSplitRightView(target: OutreachCoordinator, topView: NamesField2, container: inputsView, leftView: OCTitle)
        
        initSplitRightViewLessTopPadding(target: OutreachCoordinatorEmail, topView: OCTitle, container: inputsView, leftView: OutreachCoordinator)
        
        initButtonSpacing(target: leaveInputButton, topView: OutreachCoordinatorEmail, container: inputsView)
        
        
        inputInfo.topAnchor.constraint(equalTo: leaveInputButton.bottomAnchor, constant: 6).isActive = true
        inputInfo.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -5).isActive = true
        inputInfo.heightAnchor.constraint(equalToConstant: 75).isActive = true
        inputInfo.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 5).isActive = true


    }
    
    func setScrollViewSize(inputsView: UIScrollView){
        inputsView.contentSize = CGSize(width: inputsView.frame.width, height: CGFloat(ScrollViewHeight))
    }
    
    // Make originally black status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle { get { return .lightContent } }

    func initWideViewLessTopPadding(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -5).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
    }
    
    func initWideView(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -5).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
    }
    
    func initSplitLeftView(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initFirstSmallLeftView(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/3, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initSmallLeftView(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/3, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initSplitRightViewLessTopPadding(target: UIView, topView: UIView, container: UIView, leftView: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: 10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initSplitRightView(target: UIView, topView: UIView, container: UIView, leftView: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: 10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initFirstLargeRightView(target: UIView, topView: UIView, container: UIView, leftView: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: 10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 2/3, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initLargeRightView(target: UIView, topView: UIView, container: UIView, leftView: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: 10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 2/3, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupFirstSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: 20).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupVertLeftSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView, sideView: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func setupVertRightSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView, sideView: UIView, otherSeparator: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: sideView.rightAnchor, constant: 7).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func initButtonSpacing(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -5).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
    }
    
    func initSeparator(separator: UIView){
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setInfoText(){
        inputInfo.text = "This button isn't available because the presentation hasn't passed yet. Come back when it's over and you'll be able to leave feedback right from this app!"
    }
    
    func parseNames(names: String){
        let comma = names.index(of: ",")
        let name1 = String(names[names.startIndex..<comma!])
        let afterComma = names.index(comma!, offsetBy: 1)
        let name2 = String(names[afterComma..<names.endIndex])
        NamesField.text = name1
        NamesField2.text = name2
    }
    
    func parseDate(dateText: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date: Date! = dateFormatter.date(from: dateText)
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let dateString: String = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func parseTime(timeText: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE hh:mm a"
        let time: Date! = dateFormatter.date(from: timeText)
        dateFormatter.dateFormat = "EEEE h:mm a"
        let timeString: String = dateFormatter.string(from: time)
        return timeString
    }
    
    func checkDateUpdateButton(button: UIButton){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeIndex = presentation!.time.index(presentation!.time.startIndex, offsetBy: 3)
        let timeIndexEnd = presentation!.time.index(timeIndex, offsetBy: 5)
        let timeString = String(presentation!.time[timeIndex...timeIndexEnd])
        let currentTime = timeFormatter.date(from: timeFormatter.string(from: date))
        let presentationTime = timeFormatter.date(from: timeString)
        let currentDate = dateFormatter.date(from: dateFormatter.string(from: date))
        let presentationDate = dateFormatter.date(from: presentation!.date)
        if(presentationDate! > currentDate!){
            button.backgroundColor = UIColor(r: 128, g: 128, b: 128)
            button.isEnabled = false
            setInfoText()
        }
        else{
            if(presentationTime! >= currentTime!){
                button.backgroundColor = UIColor(r: 128, g: 128, b: 128)
                button.isEnabled = false
                setInfoText()
            }
        }
    }
    
    func detailToast() {
        self.view.makeToast("Form Submission Complete")
    }

}

