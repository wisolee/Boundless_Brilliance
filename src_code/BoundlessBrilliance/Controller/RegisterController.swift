//
//  RegisterController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/14/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    // Spinner options for chapterTextField
    let chapters = ["", "Chapter 1", "Chapter 2", "Chapter 3"]
    
    // subview - emailTextField
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - passwordTextField
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - chapterTextField
    let chapterTextField: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "chapter"
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
        
        // Add action to registerButton
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    
    // registerButton action
    @objc func handleRegister() {
        // Ensure email and password are valid values
        guard let email = emailTextField.text, let password = passwordTextField.text
            else {
                print("Form input is not valid")
                return
        }
        
        // Register User
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print("Error in creating account")
                return
            }
            // Successful Authentication, now save user
            /*Store user info, temporarily set fire db rules to true, by default both set to fault*/
            // Allowing data to be saved
//            var ref: DatabaseReference!
//    
//            ref = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
//            ref.updateChildValues(["someValue": 123])
        })
        
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
        let nameTextField = registerView.nameTextField
//        let emailTextField = registerView.emailTextField
        let nameSeparatorView = registerView.nameSeparatorView
        let emailSeparatorView = registerView.emailSeparatorView
//        let passwordTextField = registerView.passwordTextField
        let passwordSeparatorView = registerView.passwordSeparatorView
//        let chapterTextField = registerView.chapterTextField
        chapterTextField?.loadSpinnerOptions(spinnerOptions: chapters)
        
        view.backgroundColor = UIColor(r: 0, g: 128, b: 128);
        
    //ADDING THE SUBVIEWS TO THE MAIN VIEW-------
        
        /* Add subviews to the main vuew*/
        view.addSubview(profileImageView)
        view.addSubview(inputsView)
        view.addSubview(registerButton)
        view.addSubview(profileImageView)
        
        /* Add additional input views to inputView*/
        inputsView.addSubview(nameTextField)
        inputsView.addSubview(nameSeparatorView)
        inputsView.addSubview(emailTextField)
        inputsView.addSubview(emailSeparatorView)
        inputsView.addSubview(passwordTextField)
        inputsView.addSubview(passwordSeparatorView)
        inputsView.addSubview(chapterTextField!)
        
    //FORMAT VIEWS-----------------
        
        //Pass the views we just made to the set up functions; requires the view we are setting up plus the view above it for anchoring
        setupProfileImageView(profileImageView: profileImageView, inputsView: inputsView)
        setUpInputsView(inputsView: inputsView, nameTextField: nameTextField,
                                nameSeparatorView: nameSeparatorView,
                                emailSeparatorView: emailSeparatorView,
                                passwordSeparatorView: passwordSeparatorView)
        setupRegisterButton(inputsView: inputsView)
        
        
    }
    
// HELPER FUNCTIONS FOR SETTING UP THE VIEWS---------------------------------------------------------------------------------
    
    func setupProfileImageView(profileImageView: UIImageView, inputsView: UIView) {
        /* need x, y, width, height contraints */
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    func setUpInputsView(inputsView: UIView, nameTextField: UITextField, nameSeparatorView: UIView, emailSeparatorView: UIView, passwordSeparatorView: UIView) {
        
        /* inputsView: need x, y, width, height contraints */
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        // nameTextField: need x, y, width, height contraints
        nameTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/4).isActive = true // 1/4 of entire height
        
        // nameSeparatorView: need x, y, width, height contraints
        nameSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        nameSeparatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        nameSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // emailTextField: need x, y, width, height contraints
        emailTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/4).isActive = true // 1/4 of entire height
        
        // emailSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // passwordTextField: need x, y, width, height contraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/4).isActive = true // 1/4 of entire height
        
        // passwordSeparatorView need x, y, width, height contraints
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // chapterTextField need x, y, width, height contraints
        chapterTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        chapterTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        chapterTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        chapterTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/4).isActive = true // 1/4 of entire height
        
    }
    
    func setupRegisterButton(inputsView: UIView) {
        /* need x, y, width, height contraints */
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
