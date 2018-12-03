//
//  RegisterController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/14/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase
import Toast_Swift

class RegisterController: UIViewController {
    
    // Spinner options for chapter field
    let chapters = ["", "Azusa Pacific University", "Los Angeles Trade Tech College", "Occidental College"]
    let member_types = ["", "Presenter", "Outreach Coordinator", "Management"]
    
    // Initialization of name text field
    let name_text_field: UITextField = {
        let name_tf = UITextField()
        name_tf.placeholder = "Name"
        name_tf.translatesAutoresizingMaskIntoConstraints = false
        return name_tf
    }()
    
    // Initialization of email text field
    let email_text_field: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        return tf
    }()
    
    // Initialization of password text field
    let password_text_field: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        return tf
    }()
    
    // Initialization of chapter field
    let chapter_text_field: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Chapter"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // Initialization of member type field
    let member_type_text_field: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Member Type"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // Initialization of register button
    let register_button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 163, b: 173)
        button.setTitle("Register", for: .normal)
        
        // Must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to register button
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    // Register button action -- Create user and send to Firebase
    @objc func handleRegister() {
        // Ensures email and password are valid values
        guard let name = name_text_field.text, let email = email_text_field.text, let password = password_text_field.text, let chapter = chapter_text_field.text, let member_type = member_type_text_field.text
            else {
                self.view.makeToast("Form input is not valid.")
                return
        }
        
        // Create a new user with info from fields if field inputs pass all validation checks
        if inputsAreValid(name: name, email: email, password: password, chapter: chapter, member_type: member_type) {
            createUser(name: name, email: email, password: password, chapter: chapter, member_type: member_type)
        } else {
            return
        }
    }
    
    // Initialization of 'return to login' button
    let return_button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.setTitle("Return to Login", for: .normal)
        
        // Must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 0, g: 163, b: 173), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to register button
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    // Navigate back to login page
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // Load main display for register screen
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        // Get a reference to the register view UIView
        let register_view = RegisterView()
        
        // Get the variables from the register view
        let profile_image_view = register_view.profile_image_view
        let inputs_view = register_view.inputs_view
        let name_separator_view = register_view.name_separator_view
        let email_separator_view = register_view.email_separator_view
        let password_separator_view = register_view.password_separator_view
        let chapter_separator_view = register_view.chapter_separator_view
        
        // Set up spinners for chapter and member type options
        chapter_text_field?.loadChapterOptions(spinnerOptions: chapters)
        member_type_text_field?.loadMemberTypeOptions(spinnerOptions: member_types)
        
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255);
 
        // Add subviews to the main view
        view.addSubview(profile_image_view)
        view.addSubview(inputs_view)
        view.addSubview(register_button)
        view.addSubview(profile_image_view)
        view.addSubview(return_button)
        
        // Add additional input fields to inputView
        inputs_view.addSubview(name_text_field)
        inputs_view.addSubview(name_separator_view)
        inputs_view.addSubview(email_text_field)
        inputs_view.addSubview(email_separator_view)
        inputs_view.addSubview(password_text_field)
        inputs_view.addSubview(password_separator_view)
        
        inputs_view.addSubview(chapter_text_field!)
        inputs_view.addSubview(chapter_separator_view)
        inputs_view.addSubview(member_type_text_field!)
        
        // Pass the views we just made to the set up functions; requires the view we are setting up
        // plus the view above it for anchoring
        setupProfileImageView(profile_image_view: profile_image_view, inputs_view: inputs_view)
        setUpInputsView(inputs_view: inputs_view, name_separator_view: name_separator_view,
                                email_separator_view: email_separator_view,
                                password_separator_view: password_separator_view,
                                chapter_separator_view: chapter_separator_view)
        setupRegisterButton(inputs_view: inputs_view)
        setupReturnButton(inputs_view: inputs_view)
    }
    
    // Returns true if all inputs are valid
    func inputsAreValid(name: String, email: String, password: String, chapter: String, member_type: String) -> Bool {
        if (nameNotEntered(name: name) ||
            invalidEmailFormat(email: email) ||
            passwordTooShort(password: password) ||
            chapterNotSelected(chapter: chapter) ||
            memberTypeNotSelected(member_type: member_type)) {
            return false
        }
        return true
    }
    
    // Checks for valid name field entry
    func nameNotEntered(name: String) -> Bool {
        if name == "" {
            self.view.makeToast("Please enter a name.")
            return true
        }
        return false
    }
    
    // Checks for valid email field entry
    func invalidEmailFormat(email: String) -> Bool {
        let email_reg_ex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let email_test = NSPredicate(format:"SELF MATCHES %@", email_reg_ex)
        let valid_email = email_test.evaluate(with: email)
        
        if !valid_email {
            self.view.makeToast("Please enter a valid email.")
            return true
        }
        return false
    }
    
    // Checks for valid password field entry
    func passwordTooShort(password: String) -> Bool {
        if password.count < 7 {
            self.view.makeToast("Password too short")
            return true
        }
        return false
    }
    
    // Checks for valid chapter field entry
    func chapterNotSelected(chapter: String) -> Bool {
        if chapter == "" {
            self.view.makeToast("Please choose a chapter.")
            return true
        }
        return false
    }
    
    // Checks for valid member field entry
    func memberTypeNotSelected(member_type: String) -> Bool {
        if member_type == "" {
            self.view.makeToast("Please choose a member type.")
            return true
        }
        return false
    }
    
    // If input validations are passed, attempt to create a user
    func createUser(name: String, email: String, password: String, chapter: String, member_type: String) {
        // Register User
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.view.makeToast("Error in creating account")
                return
            } else {
                // Successful Authentication, now save user
                var ref: DatabaseReference!
                ref = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
                let user_ID = Auth.auth().currentUser!.uid
                
                // Save user to users table
                self.putIntoUsersTable(ref: ref, user_ID: user_ID, name: name, email: email, chapter: chapter, member_type: member_type)
                
                // Save user to chapters table
                self.putIntoChaptersTable(ref: ref, user_ID: user_ID, name: name, chapter: chapter)
                
                // After saving all the data successfully, navigate back to login screen
                self.navigationController?.popViewController(animated: true)
            }
        })
    }
    
    // Add user to users table in Firebase
    func putIntoUsersTable(ref: DatabaseReference, user_ID: String, name: String, email: String, chapter: String, member_type: String) {
        let user_ref = ref.child("users").child(user_ID)
        let user_fields = ["name" : name,
                          "email" : email,
                          "chapter" : chapter,
                          "member_type" : member_type]
        
        updateTable(ref: user_ref, value: user_fields)
    }
    
    // Add user to chapters table in Firebase
    func putIntoChaptersTable(ref: DatabaseReference, user_ID: String, name: String, chapter: String) {
        let chapter_ref = ref.child("chapters").child(chapter)
        let member = [user_ID : name]
        
        updateTable(ref: chapter_ref, value: member)
    }
    
    // Update Firebase data table
    func updateTable(ref: DatabaseReference, value: Dictionary <String, String>) {
        ref.updateChildValues(value) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
    }
    
    // Set up logo with constraints
    func setupProfileImageView(profile_image_view: UIImageView, inputs_view: UIView) {
        profile_image_view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profile_image_view.bottomAnchor.constraint(equalTo: inputs_view.topAnchor, constant: -50).isActive = true
        profile_image_view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profile_image_view.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    // Set up input fields with constraints
    func setUpInputsView(inputs_view: UIView, name_separator_view: UIView, email_separator_view: UIView, password_separator_view: UIView, chapter_separator_view: UIView) {
        inputs_view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputs_view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputs_view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputs_view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        // Set up constraints for name text field
        name_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        name_text_field.topAnchor.constraint(equalTo: inputs_view.topAnchor).isActive = true
        name_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        name_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true
        
        // Set up constraints for name separator view
        name_separator_view.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        name_separator_view.topAnchor.constraint(equalTo: name_text_field.bottomAnchor).isActive = true
        name_separator_view.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        name_separator_view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Set up constraints for email text field
        email_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        email_text_field.topAnchor.constraint(equalTo: name_text_field.bottomAnchor).isActive = true
        email_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        email_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true
        
        // Set up constraints for email separator view
        email_separator_view.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        email_separator_view.topAnchor.constraint(equalTo: email_text_field.bottomAnchor).isActive = true
        email_separator_view.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        email_separator_view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Set up constraints for password text field
        password_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        password_text_field.topAnchor.constraint(equalTo: email_text_field.bottomAnchor).isActive = true
        password_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        password_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true
        
        // Set up constraints for password separator view
        password_separator_view.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        password_separator_view.topAnchor.constraint(equalTo: password_text_field.bottomAnchor).isActive = true
        password_separator_view.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        password_separator_view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Set up constraints for chapter text field
        chapter_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        chapter_text_field.topAnchor.constraint(equalTo: password_text_field.bottomAnchor).isActive = true
        chapter_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        chapter_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true
        
        // Set up constraints for chapter separator view
        chapter_separator_view.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        chapter_separator_view.topAnchor.constraint(equalTo: chapter_text_field.bottomAnchor).isActive = true
        chapter_separator_view.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        chapter_separator_view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Set up constraints for member type text field
        member_type_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        member_type_text_field.topAnchor.constraint(equalTo: chapter_text_field.bottomAnchor).isActive = true
        member_type_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        member_type_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true
    }
    
    // Set up constraints for register button
    func setupRegisterButton(inputs_view: UIView) {
        register_button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        register_button.topAnchor.constraint(equalTo: inputs_view.bottomAnchor, constant: 12).isActive = true
        register_button.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        register_button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // Set up constraints for return button
    func setupReturnButton(inputs_view: UIView) {
        return_button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return_button.topAnchor.constraint(equalTo: register_button.bottomAnchor, constant: 12).isActive = true
        return_button.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        return_button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // Make originally black status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle { get { return .lightContent } }
}
