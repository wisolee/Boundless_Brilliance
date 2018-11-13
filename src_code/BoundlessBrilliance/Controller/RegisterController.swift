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
        let returnToLoginController = LoginScreenController()
        self.present(returnToLoginController, animated: true)
    }
    
    // registerButton action -- Send data to Firebase
    @objc func handleRegister() {
        // Ensure email and password are valid values
        guard let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let chapter = chapterTextField.text, let memberType = memberTypeTextField.text
            else {
                print("Form input is not valid")
                return
        }

        if password.count < 7 {
            //print("Password must be at least 7 characters.")
            self.view.makeToast("Password must be at least 7 characters.")
            return
        } else if chapter == "" {
            self.view.makeToast("Please choose a chapter.")
            return
        } else if memberType == "" {
            self.view.makeToast("Please choose a member type.")
            return
        } else {
            // Register User
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    //print("Error in creating account")
                    self.view.makeToast("Error in creating account")
                    return
                } else {
                    // Successful Authentication, now save user
                    /*Store user info, temporarily set fire db rules to true, by default both set to fault*/
                    var ref: DatabaseReference!
                    
                    //save user to users table
                    ref = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
                    let userID = Auth.auth().currentUser!.uid
                    
                    let userRef = ref.child("users").child(userID)
                    let userFields = ["name" : name,
                                      "email" : email,
                                      "chapter" : chapter,
                                      "memberType" : memberType]
                    
                    // updateChildValues with completion block
                    userRef.updateChildValues(userFields) {
                        (error:Error?, ref:DatabaseReference) in
                        if let error = error {
                            print("Data could not be saved: \(error).")
                        } else {
                            print("Data saved successfully!")
                        }
                    }
                    
                    
                    //Now save the user under the appropriate chapter table
                    let chapterRef = ref.child("chapters").child(chapter)
                    let member = [userID : name]

                    chapterRef.updateChildValues(member) {
                        (error:Error?, ref:DatabaseReference) in
                        if let error = error {
                            print("Data could not be saved: \(error).")
                        } else {
                            print("Data saved successfully!")
                        }
                    }

                    //after saving all the data successfully, navigate back to login screen
                    let newViewController = LoginScreenController()
                    self.present(newViewController, animated: true)
                }
               
            })
        }
    }
    
// MAIN DISPLAY -------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
// HELPER FUNCTIONS FOR SETTING UP THE VIEWS---------------------------------------------------------------------------------
    
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

// Convenient extension of UIColor, simplier initialization
extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
