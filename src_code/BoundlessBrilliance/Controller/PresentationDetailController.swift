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
    let scroll_view_height = 750
    let sticker_options = ["", "yes", "no"]
    let shirt_options = ["", "yes", "no"]
    var shirt_sizes = ["", "extra-small", "small", "medium", "large", "extra-large"]
    
    // The title text for Time
    let time_title: UITextView! = {
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
    
    // The actual date that the presentation happens
    let date_text: UITextView! = {
        $0.text = "2018-12-30"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 30)
        $0.textColor = UIColor(r: 0, g: 163, b: 173)
        return $0
    }(UITextView())
    
    // The actual time in military time
    let time: UITextView! = {
        $0.text = "14:00"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 20)
        $0.textColor = UIColor(r: 0, g: 163, b: 173)
        return $0
    }(UITextView())
    
    // The text title for Teachers
    let teacher_title: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Teacher: "
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // The actual teacher name
    let teacher: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Ms. Crabapple"
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // The teacher's actual email
    let teacher_email: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "mscrabapple@gmail.com"
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // The grade of the class
    let grade: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "3"
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // The nnmber of students
    let grade_label: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Grade:"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // The room number text title
    let room_num_title: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Room Number: "
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // The actual classroom number
    let room_num: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "32"
        $0.isEditable = false
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())

    // The outreach coordinator text title
    let oc_title: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Outreach Coordinator: "
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // The actual outreach coordinator
    let outreach_coordinator: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "Audrey Shawley"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // The outreach coordinator email
    let outreach_coordinator_email: UITextView! = {
        $0.textColor = UIColor.black
        $0.text = "OC@gmail.com"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isEditable = false
        $0.textAlignment = NSTextAlignment.right
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // The sticker text title with the spinner for options
    let sticker_dropdown: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "Sticker?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.center
        $0.backgroundColor = UIColor.white
        $0.borderStyle = UITextField.BorderStyle.line
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // The t-shirt text title with the spinner for options
    let shirt_dropdown: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "T-Shirt?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.center
        $0.backgroundColor = UIColor.white
        $0.borderStyle = UITextField.BorderStyle.line
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // The t-shirt text title with the spinner for options
    let shirt_size_dropdown: UITextField! = {
        $0.placeholder = "Shirt Size"
        $0.textAlignment = NSTextAlignment.center
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.borderStyle = UITextField.BorderStyle.line
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // The text title for the location
    let loc_field_title: UITextView! = {
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
    
    // The actual location of the presentation
    let loc_field: UITextView = {
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

    // The text title for the presenters
    let names_field_title: UITextView = {
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
    
    // The first name of the presenter
    let names_field_1: UITextView = {
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

    
    // The second name of the presenter
    let names_field_2: UITextView = {
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
    
    // The put to be able to enter the survey from each presentation detail view
    public lazy var leave_input_button: UIButton = {
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
    
    // The block of text displayed if the post-presentation survey is not yet able to be entered
    let input_info: UILabel = {
        $0.text = ""
        $0.textAlignment = NSTextAlignment.center
        $0.numberOfLines = 3
        $0.textColor = UIColor.gray
        $0.resignFirstResponder()
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: 13)
        return $0
    }(UILabel())
    
    
    // Start of functions
    
    // enterSurvey() goes to the next page - the survey
    @objc func enterSurvey() {
        let surveyController = SurveyController()
        surveyController.presentation = presentation
        super.navigationController?.pushViewController(surveyController, animated: true)
    }
    
    // Main viewDidLoad() function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create variables
        let presDetailView  = PresentationDetailView()
        let scrollContainer = presDetailView.scroll_container
        let inputsView = presDetailView.inputs_view
        
        // Adds subviews
        view.addSubview(scrollContainer)
        scrollContainer.addSubview(inputsView)
        
        // Parses the date and time to our intended format
        time.text = parseTime(timeText: (presentation?.time)!)
        date_text.text = parseDate(dateText: (presentation?.date)!)
        
        // Gets the text for these parts of the presentation object
        loc_field.text = presentation?.location
        names_field_1.text = presentation?.names
        teacher.text = presentation?.teacher_name
        teacher_email.text = presentation?.teacher_email
        grade.text = presentation?.grade.stringValue
        room_num.text = presentation?.room_number.stringValue
        
        // Parses the presenter names to display in our inteded format
        parseNames(names: (presentation?.names)!)
        
        // Checks the button to make sure that the date has passed so that the user is able to enter the post-presentation survey
        checkDateUpdateButton(button: leave_input_button)
        
        // Set up InputsView
        setupInputsView(inputsView: inputsView, scrollView: scrollContainer)
        
        // Set up the spinners for all the questions that have multiple options
        sticker_dropdown?.loadStickerShirtOptions(spinnerOptions: sticker_options)
        shirt_dropdown?.loadStickerShirtOptions(spinnerOptions: shirt_options)
        shirt_size_dropdown?.loadStickerShirtOptions(spinnerOptions: shirt_sizes)
        
        // Sets background color for the screen
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
    }
    
    
    func setupInputsView(inputsView: UIView, scrollView: UIScrollView){
        
        // Set up the constraints for the scrollView
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        // Set up the constraints for the inputsView
        inputsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        inputsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        inputsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        inputsView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        inputsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // Add subviews for date, time, location
        inputsView.addSubview(date_text)
        inputsView.addSubview(time)
        inputsView.addSubview(loc_field_title)
        inputsView.addSubview(loc_field)
        
        // Set up the separators on this page
        let separator_1 = UIView()
        let separator_2 = UIView()
        let separator_3 = UIView()
        let separator_4 = UIView()
        let separator_5 = UIView()
        
        // Separator 1
        initSeparator(separator: separator_1)
        inputsView.addSubview(separator_1)
        setupSeparator(emailSeparatorView: separator_1, inputsView: inputsView, aboveView: loc_field_title)
        
        // Add subviews for room
        inputsView.addSubview(room_num_title)
        inputsView.addSubview(room_num)
        
        // Separator 2
        initSeparator(separator: separator_2)
        inputsView.addSubview(separator_2)
        setupSeparator(emailSeparatorView: separator_2, inputsView: inputsView, aboveView: room_num_title)
        
        // Add subviews for teacher
        inputsView.addSubview(teacher_title)
        inputsView.addSubview(teacher)
        inputsView.addSubview(teacher_email)
        
        // Separator 3
        initSeparator(separator: separator_3)
        inputsView.addSubview(separator_3)
        setupSeparator(emailSeparatorView: separator_3, inputsView: inputsView, aboveView: teacher_email)

        // Add subviews for grade
        inputsView.addSubview(grade)
        inputsView.addSubview(grade_label)
        
        // Separator 4
        initSeparator(separator: separator_4)
        inputsView.addSubview(separator_4)
        setupSeparator(emailSeparatorView: separator_4, inputsView: inputsView, aboveView: grade)
        
        // Add subviews for presenters
        inputsView.addSubview(names_field_title)
        inputsView.addSubview(names_field_1)
        inputsView.addSubview(names_field_2)
        
        // Separator 5
        initSeparator(separator: separator_5)
        inputsView.addSubview(separator_5)
        setupSeparator(emailSeparatorView: separator_5, inputsView: inputsView, aboveView: names_field_2)
        
        // Add subviews for outreach coordinator
        inputsView.addSubview(oc_title)
        inputsView.addSubview(outreach_coordinator)
        inputsView.addSubview(outreach_coordinator_email)
        
        // Add subviews for button and/or the message about when the survey can be accessed
        inputsView.addSubview(leave_input_button)
        inputsView.addSubview(input_info)
        
        // Call functions to initialize all the views
        initWideView(target: date_text, topView: inputsView, container: inputsView)
        date_text.topAnchor.constraint(equalTo: inputsView.topAnchor, constant: 6).isActive = true
        initWideView(target: time, topView: date_text, container: inputsView)
        time.topAnchor.constraint(equalTo: date_text.bottomAnchor).isActive = true
        initFirstSmallLeftView(target: loc_field_title, topView: time, container: inputsView)
        initFirstLargeRightView(target: loc_field, topView: time, container: inputsView, leftView: loc_field_title)
        initSplitLeftView(target: room_num_title, topView: loc_field_title, container: inputsView)
        initSplitRightView(target: room_num, topView: loc_field, container: inputsView, leftView: room_num_title)
        initSplitLeftView(target: teacher_title, topView: room_num_title, container: inputsView)
        initSplitRightView(target: teacher, topView: room_num_title, container: inputsView, leftView: teacher_title)
        initSplitRightViewLessTopPadding(target: teacher_email, topView: teacher_title, container: inputsView, leftView: teacher_title)
        initSplitLeftView(target: grade_label, topView: teacher_email, container: inputsView)
        initSplitRightView(target: grade, topView: teacher_email, container: inputsView, leftView: grade_label)
        initSplitLeftView(target: names_field_title, topView: grade_label, container: inputsView)
        initSplitRightView(target: names_field_1, topView: grade_label, container: inputsView, leftView: names_field_title)
        initSplitRightViewLessTopPadding(target: names_field_2, topView: names_field_1, container: inputsView, leftView: names_field_title)
        initSplitLeftView(target: oc_title, topView: names_field_2, container: inputsView)
        initSplitRightView(target: outreach_coordinator, topView: names_field_2, container: inputsView, leftView: oc_title)
        initSplitRightViewLessTopPadding(target: outreach_coordinator_email, topView: oc_title, container: inputsView, leftView: outreach_coordinator)
        initButtonSpacing(target: leave_input_button, topView: outreach_coordinator_email, container: inputsView)
    
        // Defining elements for the message that displays if the date hasn't yet passed for the post-presentation survey
        input_info.topAnchor.constraint(equalTo: leave_input_button.bottomAnchor, constant: 6).isActive = true
        input_info.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -5).isActive = true
        input_info.heightAnchor.constraint(equalToConstant: 75).isActive = true
        input_info.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 5).isActive = true
    }
    
    // Makes the app scrollable
    func setScrollViewSize(inputsView: UIScrollView){
        inputsView.contentSize = CGSize(width: inputsView.frame.width, height: CGFloat(scroll_view_height))
    }
    
    // Make originally black status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle { get { return .lightContent } }

    //Initalizes all the views

    func initWideViewLessTopPadding(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -5).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
    }
    
    func initWideView(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -5).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
    }
    
    func initSplitLeftView(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initFirstSmallLeftView(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/3, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initSmallLeftView(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/3, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initSplitRightViewLessTopPadding(target: UIView, topView: UIView, container: UIView, leftView: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: 10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initSplitRightView(target: UIView, topView: UIView, container: UIView, leftView: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: 10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initFirstLargeRightView(target: UIView, topView: UIView, container: UIView, leftView: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: 10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 2/3, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initLargeRightView(target: UIView, topView: UIView, container: UIView, leftView: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: 10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 2/3, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupFirstSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView) {
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: 20).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView) {
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupVertLeftSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView, sideView: UIView) {
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func setupVertRightSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView, sideView: UIView, otherSeparator: UIView) {
        emailSeparatorView.leftAnchor.constraint(equalTo: sideView.rightAnchor, constant: 7).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func initButtonSpacing(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -5).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
    }
    
    func initSeparator(separator: UIView) {
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // Sets up the message that will be displayed if the date hasn't yet passed
    func setInfoText() {
        input_info.text = "This button isn't available because the presentation hasn't passed yet. Come back when it's over and you'll be able to leave feedback right from this app!"
    }
    
    // Parses the presenter names for our intended format
    func parseNames(names: String) {
        let comma = names.index(of: ",")
        let name_1 = String(names[names.startIndex..<comma!])
        let after_comma = names.index(comma!, offsetBy: 1)
        let name_2 = String(names[after_comma..<names.endIndex])
        names_field_1.text = name_1
        names_field_2.text = name_2
    }
    
    // Parses the date so it displays correctly
    func parseDate(dateText: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date: Date! = dateFormatter.date(from: dateText)
        dateFormatter.dateFormat = "MMMM d, yyyy"
        let date_string: String = dateFormatter.string(from: date)
        return date_string
    }
    
    // Parses the time so it displays correctly
    func parseTime(timeText: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE hh:mm a"
        let time: Date! = dateFormatter.date(from: timeText)
        dateFormatter.dateFormat = "EEEE h:mm a"
        let time_string: String = dateFormatter.string(from: time)
        return time_string
    }
    
    // Checks the date of the presentation vs the date today to open the survey or not
    func checkDateUpdateButton(button: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let time_index = presentation!.time.index(presentation!.time.startIndex, offsetBy: 3)
        let time_index_end = presentation!.time.index(time_index, offsetBy: 5)
        let time_string = String(presentation!.time[time_index...time_index_end])
        let current_time = timeFormatter.date(from: timeFormatter.string(from: date))
        let presentation_time = timeFormatter.date(from: time_string)
        let current_date = dateFormatter.date(from: dateFormatter.string(from: date))
        let presentation_date = dateFormatter.date(from: presentation!.date)
        
        // If the date is not yet passed, disbable the button and display message
        if(presentation_date! > current_date!){
            button.backgroundColor = UIColor(r: 128, g: 128, b: 128)
            button.isEnabled = false
            setInfoText()
        } else {
            if(presentation_time! >= current_time!) {
                button.backgroundColor = UIColor(r: 128, g: 128, b: 128)
                button.isEnabled = false
                setInfoText()
            }
        }
    }
}

