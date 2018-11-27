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
    
    // Spinner options for chapter_text_field
    //TODO: in the future, we should pull chapter names from the database in case there are new chapters
    let chapters = ["", "Azusa Pacific University", "Los Angeles Trade Tech College", "Occidental College"]
    let member_types = ["", "Presenter", "Outreach Coordinator", "Management"]
    
    // subview - name_text_field
    let name_text_field: UITextField = {
        let name_tf = UITextField()
        name_tf.placeholder = "Name"
        name_tf.translatesAutoresizingMaskIntoConstraints = false
        return name_tf
    }()
    
    // subview - email_text_field
    let email_text_field: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - password_text_field
    let password_text_field: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        return tf
    }()
    
    // subview - chapter_text_field
    let chapter_text_field: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Chapter"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - chapter_text_field
    let member_type_text_field: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Member Type"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - register_button
    let register_button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        button.setTitle("Register", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to register_button
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    // register_button action -- Send data to Firebase
    @objc func handleRegister() {
        
        // Ensure email and password are valid values
        // Note: It seems that this doesn't function as intended: toast will not be fired if the entire form is empty, which seems like is what is supposed to happen...?
        guard let name = name_text_field.text, let email = email_text_field.text, let password = password_text_field.text, let chapter = chapter_text_field.text, let member_type = member_type_text_field.text
            else {
                self.view.makeToast("Form input is not valid.")
                return
        }
        
        // Create a new user with info from form if form inputs pass all validation checks
        if inputsAreValid(name: name, email: email, password: password, chapter: chapter, member_type: member_type) {
            createUser(name: name, email: email, password: password, chapter: chapter, member_type: member_type)
        } else {
            return
        }
    }
    
    // subview - return_button
    let return_button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.setTitle("Return to Login", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 0, g: 128, b: 128), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to register_button
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        
        return button
    }()
    
    @objc func goBack(){
        //go back to login
        self.navigationController?.popViewController(animated: true)
    }
    
    
// MAIN DISPLAY -------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    //NAMING VARIABLES ----------
        

        //Get a reference to the register_view UIView
        let register_view = RegisterView()
        
        
        //Get the variables from the register_view
        let profile_image_view = register_view.profile_image_view
        let inputs_view = register_view.inputs_view
        
        //Still getting variables from register_view: these will be added as subviews to the inputs_view: register_view > inputs_view > these variables

        let name_separator_view = register_view.name_separator_view
        let emailSeparatorView = register_view.email_separator_view
        let passwordSeparatorView = register_view.password_separator_view
        let chapterSeparatorView = register_view.chapter_separator_view
        chapter_text_field?.loadChapterOptions(spinnerOptions: chapters)
        member_type_text_field?.loadMemberTypeOptions(spinnerOptions: member_types)
        
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255);
        
    //ADDING THE SUBVIEWS TO THE MAIN VIEW-------
        
        /* Add subviews to the main vuew*/
        view.addSubview(profile_image_view)
        view.addSubview(inputs_view)
        view.addSubview(register_button)
        view.addSubview(profile_image_view)
        view.addSubview(return_button)
        
        /* Add additional input views to inputView*/
        inputs_view.addSubview(name_text_field)
        inputs_view.addSubview(name_separator_view)
        inputs_view.addSubview(email_text_field)
        inputs_view.addSubview(emailSeparatorView)
        inputs_view.addSubview(password_text_field)
        inputs_view.addSubview(passwordSeparatorView)
        
        inputs_view.addSubview(chapter_text_field!)
        inputs_view.addSubview(chapterSeparatorView)
        inputs_view.addSubview(member_type_text_field!)
        
    //FORMAT VIEWS-----------------
        
        //Pass the views we just made to the set up functions; requires the view we are setting up plus the view above it for anchoring
        setupProfileImageView(profile_image_view: profile_image_view, inputs_view: inputs_view)
        setUpInputsView(inputs_view: inputs_view, name_separator_view: name_separator_view,
                                emailSeparatorView: emailSeparatorView,
                                passwordSeparatorView: passwordSeparatorView,
                                chapterSeparatorView: chapterSeparatorView)
        setupRegisterButton(inputs_view: inputs_view)
        setupReturnButton(inputs_view: inputs_view)
        
        
    }
    
 
   /* ---------------------------------------------------------------------------------
    * HELPER FUNCTION OVERVIEW
    * Input validation checks
    * User creation
    * Setting up views
    *---------------------------------------------------------------------------------*/
    
    // INPUT VALIDATION CHECKS---------------------------------------------------------
    
    // inputsAreValid
    // Returns true if all inputs are valid
    func inputsAreValid (name: String, email: String, password: String, chapter: String, member_type: String) -> Bool {
        print ("inputsAreValid() entered")
        
        if (nameNotEntered(name: name) ||
            invalidEmailFormat(email: email) ||
            passwordTooShort(password: password) ||
            chapterNotSelected(chapter: chapter) ||
            memberTypeNotSelected(member_type: member_type)) {
            
            return false
        }
        return true
    }
    
    
    // nameNotEntered, invalidEmailFormat, passwordTooShort, chapterNotSelected, memberTypeNotSelected
    // Returns true if there are any errors in the inputs
    func nameNotEntered (name: String) -> Bool {
        if name == "" {
            self.view.makeToast("Please enter a name.")
            return true
        }
        return false
    }
    
    func invalidEmailFormat (email: String) -> Bool {
        let email_reg_ex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let email_test = NSPredicate(format:"SELF MATCHES %@", email_reg_ex)
        
        let valid_email = email_test.evaluate(with: email)
        
        if !valid_email {
            self.view.makeToast("Please enter a valid email.")
            return true
        }
        return false
    }
    
    func passwordTooShort (password: String) -> Bool {
        if password.count < 7 {
            self.view.makeToast("Password too short")
            return true
        }
        return false
    }
    
    func chapterNotSelected (chapter: String) -> Bool {
        if chapter == "" {
            self.view.makeToast("Please choose a chapter.")
            return true
        }
        return false
    }
    
    func memberTypeNotSelected (member_type: String) -> Bool {
        if member_type == "" {
            self.view.makeToast("Please choose a member type.")
            return true
        }
        return false
    }
    
    
    
    // USER CREATION---------------------------------------------------------------------------------
    
    // If input validations are all good, attempt to create a user
    func createUser (name: String, email: String, password: String, chapter: String, member_type: String) {
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
                let new_view_controller = LoginScreenController()
                self.present(new_view_controller, animated: true)
            }
            
        })
    }
    
    func putIntoUsersTable (ref: DatabaseReference, user_ID: String, name: String, email: String, chapter: String, member_type: String) {
        let user_ref = ref.child("users").child(user_ID)
        let user_fields = ["name" : name,
                          "email" : email,
                          "chapter" : chapter,
                          "member_type" : member_type]
        
        updateTable(ref: user_ref, value: user_fields)
        
    }
    
    func putIntoChaptersTable (ref: DatabaseReference, user_ID: String, name: String, chapter: String) {
        //Now save the user under the appropriate chapter table
        let chapter_ref = ref.child("chapters").child(chapter)
        let member = [user_ID : name]
        
        updateTable(ref: chapter_ref, value: member)
    }
    
    func updateTable (ref: DatabaseReference, value: Dictionary <String, String>) {
        ref.updateChildValues(value) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Data could not be saved: \(error).")
            } else {
                print("Data saved successfully!")
            }
        }
    }
    
    
    // SETTING UP VIEWS---------------------------------------------------------------------------------
    
    func setupProfileImageView(profile_image_view: UIImageView, inputs_view: UIView) {
        /* need x, y, width, height contraints */
        profile_image_view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profile_image_view.bottomAnchor.constraint(equalTo: inputs_view.topAnchor, constant: -50).isActive = true
        profile_image_view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profile_image_view.heightAnchor.constraint(equalToConstant: 125).isActive = true
    
    }
    

    func setUpInputsView(inputs_view: UIView, name_separator_view: UIView, emailSeparatorView: UIView, passwordSeparatorView: UIView, chapterSeparatorView: UIView) {
        
        /* inputs_view: need x, y, width, height contraints */
        inputs_view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputs_view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputs_view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputs_view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        // name_text_field: need x, y, width, height contraints
        name_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        name_text_field.topAnchor.constraint(equalTo: inputs_view.topAnchor).isActive = true
        name_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        name_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
        // name_separator_view: need x, y, width, height contraints
        name_separator_view.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        name_separator_view.topAnchor.constraint(equalTo: name_text_field.bottomAnchor).isActive = true
        name_separator_view.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        name_separator_view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // email_text_field: need x, y, width, height contraints
        email_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        email_text_field.topAnchor.constraint(equalTo: name_text_field.bottomAnchor).isActive = true
        email_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        email_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
        // emailSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: email_text_field.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // password_text_field: need x, y, width, height contraints
        password_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        password_text_field.topAnchor.constraint(equalTo: email_text_field.bottomAnchor).isActive = true
        password_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        password_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
        // passwordSeparatorView need x, y, width, height contraints
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: password_text_field.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // chapter_text_field need x, y, width, height contraints
        chapter_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        chapter_text_field.topAnchor.constraint(equalTo: password_text_field.bottomAnchor).isActive = true
        chapter_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        chapter_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
        // chapterSeparatorView need x, y, width, height contraints
        chapterSeparatorView.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        chapterSeparatorView.topAnchor.constraint(equalTo: chapter_text_field.bottomAnchor).isActive = true
        chapterSeparatorView.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        chapterSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // member_type_text_field need x, y, width, height constraints
        member_type_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        member_type_text_field.topAnchor.constraint(equalTo:chapter_text_field.bottomAnchor).isActive = true
        member_type_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        member_type_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
    }
    
    func setupRegisterButton(inputs_view: UIView) {
        /* need x, y, width, height contraints */
        register_button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        register_button.topAnchor.constraint(equalTo: inputs_view.bottomAnchor, constant: 12).isActive = true
        register_button.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        register_button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupReturnButton(inputs_view: UIView){
        return_button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        return_button.topAnchor.constraint(equalTo: register_button.bottomAnchor, constant: 12).isActive = true
        return_button.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        return_button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    

// Make originally black status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle { get { return .lightContent } }
}
