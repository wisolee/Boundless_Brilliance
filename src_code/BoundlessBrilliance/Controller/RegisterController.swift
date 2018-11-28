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
    
    // Spinner options for chapterTextField
    //TODO: in the future, we should pull chapter names from the database in case there are new chapters
    let chapters = ["", "Azusa Pacific University", "Los Angeles Trade Tech College", "Occidental College"]
    let memberTypes = ["", "Presenter", "Outreach Coordinator", "Management"]
    
    // subview - nameTextField
    let nameTextField: UITextField = {
        let name_tf = UITextField()
        name_tf.placeholder = "Name"
        name_tf.translatesAutoresizingMaskIntoConstraints = false
        return name_tf
    }()
    
    // subview - emailTextField
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - passwordTextField
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        return tf
    }()
    
    // subview - chapterTextField
    let chapterTextField: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Chapter"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - chapterTextField
    let memberTypeTextField: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Member Type"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - registerButton
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        button.setTitle("Register", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to registerButton
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    // registerButton action -- Send data to Firebase
    @objc func handleRegister() {
        
        // Ensure email and password are valid values
        // Note: It seems that this doesn't function as intended: toast will not be fired if the entire form is empty, which seems like is what is supposed to happen...?
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let chapter = chapterTextField.text, let memberType = memberTypeTextField.text
            else {
                self.view.makeToast("Form input is not valid.")
                return
        }
        
        // Create a new user with info from form if form inputs pass all validation checks
        if inputsAreValid(name: name, email: email, password: password, chapter: chapter, memberType: memberType) {
            createUser(name: name, email: email, password: password, chapter: chapter, memberType: memberType)
        } else {
            return
        }
    }
    
    // subview - returnButton
    let returnButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.setTitle("Return to Login", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 0, g: 128, b: 128), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to registerButton
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
        

        //Get a reference to the RegisterView UIView
        let registerView = RegisterView()
        
        
        //Get the variables from the registerView
        let profileImageView = registerView.profileImageView
        let inputsView = registerView.inputsView
        
        //Still getting variables from registerView: these will be added as subviews to the inputsView: registerView > inputsView > these variables

        let nameSeparatorView = registerView.nameSeparatorView
        let emailSeparatorView = registerView.emailSeparatorView
        let passwordSeparatorView = registerView.passwordSeparatorView
        let chapterSeparatorView = registerView.chapterSeparatorView
        chapterTextField?.loadChapterOptions(spinnerOptions: chapters)
        memberTypeTextField?.loadMemberTypeOptions(spinnerOptions: memberTypes)
        
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255);
        
    //ADDING THE SUBVIEWS TO THE MAIN VIEW-------
        
        /* Add subviews to the main vuew*/
        view.addSubview(profileImageView)
        view.addSubview(inputsView)
        view.addSubview(registerButton)
        view.addSubview(profileImageView)
        view.addSubview(returnButton)
        
        /* Add additional input views to inputView*/
        inputsView.addSubview(nameTextField)
        inputsView.addSubview(nameSeparatorView)
        inputsView.addSubview(emailTextField)
        inputsView.addSubview(emailSeparatorView)
        inputsView.addSubview(passwordTextField)
        inputsView.addSubview(passwordSeparatorView)
        
        inputsView.addSubview(chapterTextField!)
        inputsView.addSubview(chapterSeparatorView)
        inputsView.addSubview(memberTypeTextField!)
        
    //FORMAT VIEWS-----------------
        
        //Pass the views we just made to the set up functions; requires the view we are setting up plus the view above it for anchoring
        setupProfileImageView(profileImageView: profileImageView, inputsView: inputsView)
        setUpInputsView(inputsView: inputsView, nameSeparatorView: nameSeparatorView,
                                emailSeparatorView: emailSeparatorView,
                                passwordSeparatorView: passwordSeparatorView,
                                chapterSeparatorView: chapterSeparatorView)
        setupRegisterButton(inputsView: inputsView)
        setupReturnButton(inputsView: inputsView)
        
        
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
    func inputsAreValid (name: String, email: String, password: String, chapter: String, memberType: String) -> Bool {
        print ("inputsAreValid() entered")
        
        if (nameNotEntered(name: name) ||
            invalidEmailFormat(email: email) ||
            passwordTooShort(password: password) ||
            chapterNotSelected(chapter: chapter) ||
            memberTypeNotSelected(memberType: memberType)) {
            
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
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let validEmail = emailTest.evaluate(with: email)
        
        if !validEmail {
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
    
    func memberTypeNotSelected (memberType: String) -> Bool {
        if memberType == "" {
            self.view.makeToast("Please choose a member type.")
            return true
        }
        return false
    }
    
    
    
    // USER CREATION---------------------------------------------------------------------------------
    
    // If input validations are all good, attempt to create a user
    func createUser (name: String, email: String, password: String, chapter: String, memberType: String) {
        // Register User
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                self.view.makeToast("Error in creating account")
                return
            } else {
                // Successful Authentication, now save user
                var ref: DatabaseReference!
                
                
                ref = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
                let userID = Auth.auth().currentUser!.uid
                
                // Save user to users table
                self.putIntoUsersTable(ref: ref, userID: userID, name: name, email: email, chapter: chapter, memberType: memberType)
                
                // Save user to chapters table
                self.putIntoChaptersTable(ref: ref, userID: userID, name: name, chapter: chapter)
                
                
                // After saving all the data successfully, navigate back to login screen
                self.navigationController?.popViewController(animated: true)
            }
            
        })
    }
    
    func putIntoUsersTable (ref: DatabaseReference, userID: String, name: String, email: String, chapter: String, memberType: String) {
        let userRef = ref.child("users").child(userID)
        let userFields = ["name" : name,
                          "email" : email,
                          "chapter" : chapter,
                          "memberType" : memberType]
        
        updateTable(ref: userRef, value: userFields)
        
    }
    
    func putIntoChaptersTable (ref: DatabaseReference, userID: String, name: String, chapter: String) {
        //Now save the user under the appropriate chapter table
        let chapterRef = ref.child("chapters").child(chapter)
        let member = [userID : name]
        
        updateTable(ref: chapterRef, value: member)
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
    
    func setupProfileImageView(profileImageView: UIImageView, inputsView: UIView) {
        /* need x, y, width, height contraints */
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    
    }
    

    func setUpInputsView(inputsView: UIView, nameSeparatorView: UIView, emailSeparatorView: UIView, passwordSeparatorView: UIView, chapterSeparatorView: UIView) {
        
        /* inputsView: need x, y, width, height contraints */
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        // nameTextField: need x, y, width, height contraints
        nameTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
        // nameSeparatorView: need x, y, width, height contraints
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // emailTextField: need x, y, width, height contraints
        emailTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
        // emailSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // passwordTextField: need x, y, width, height contraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
        // passwordSeparatorView need x, y, width, height contraints
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // chapterTextField need x, y, width, height contraints
        chapterTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        chapterTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        chapterTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        chapterTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
        // chapterSeparatorView need x, y, width, height contraints
        chapterSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        chapterSeparatorView.topAnchor.constraint(equalTo: chapterTextField.bottomAnchor).isActive = true
        chapterSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        chapterSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // memberTypeTextField need x, y, width, height constraints
        memberTypeTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        memberTypeTextField.topAnchor.constraint(equalTo:chapterTextField.bottomAnchor).isActive = true
        memberTypeTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        memberTypeTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/5).isActive = true // 1/4 of entire height
        
    }
    
    func setupRegisterButton(inputsView: UIView) {
        /* need x, y, width, height contraints */
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupReturnButton(inputsView: UIView){
        returnButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        returnButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 12).isActive = true
        returnButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        returnButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    

// Make originally black status bar white
    override var preferredStatusBarStyle: UIStatusBarStyle { get { return .lightContent } }
}
