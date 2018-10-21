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
    
    
// MAIN DISPLAY -------------------------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //NAMING VARIABLES ----------
        
        //Get a reference to the RegisterView UIView
        let registerView = RegisterView()
        
        //Get the variables from the registerView
        let profileImageView = registerView.profileImageView
        let inputsView = registerView.inputsView
        let registerButton = registerView.registerButton
        
        //Still getting variables from registerView: these will be added as subviews to the inputsView: registerView > inputsView > these variables
        let nameTextField = registerView.nameTextField
        let emailTextField = registerView.emailTextField
        let nameSeparatorView = registerView.nameSeparatorView
        let emailSeparatorView = registerView.emailSeparatorView
        let passwordTextField = registerView.passwordTextField
        let passwordSeparatorView = registerView.passwordSeparatorView
        let chapterTextField = registerView.chapterTextField
        
        
        //let emailText:String = emailTextField.text!
        
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
        inputsView.addSubview(chapterTextField)
    
        
    //ADD ACTIONS TO VIEWS----------
        
        // Add action to registerButton
        registerButton.addTarget(self, action: #selector(handleRegister), for: UIControl.Event.touchUpInside)
        //registerButton.addTarget(self, action: #selector(handleRegister(sender:emailTextField:passwordTextField:)), for: UIControl.Event.touchUpInside)
    
        //FORMAT VIEWS-----------------
        
        //Pass the views we just made to the set up functions; requires the view we are setting up plus the view above it for anchoring
        setupProfileImageView(profileImageView: profileImageView, inputsView: inputsView)
        setUpInputsView(inputsView: inputsView,
                                nameTextField: nameTextField,
                                nameSeparatorView: nameSeparatorView,
                                emailTextField: emailTextField,
                                emailSeparatorView: emailSeparatorView,
                                passwordTextField: passwordTextField,
                                passwordSeparatorView: passwordSeparatorView,
                                chapterTextField: chapterTextField
                                )
        setupRegisterButton(registerButton: registerButton,
                                inputsView: inputsView)
        
        
    }
    
// HELPER FUNCTIONS FOR SETTING UP THE VIEWS---------------------------------------------------------------------------------
    
    func setupProfileImageView(profileImageView: UIImageView, inputsView: UIView) {
        /* need x, y, width, height contraints */
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    func setUpInputsView(inputsView: UIView, nameTextField: UITextField, nameSeparatorView: UIView, emailTextField: UITextField, emailSeparatorView: UIView, passwordTextField: UITextField, passwordSeparatorView: UIView, chapterTextField: UITextField) {
        
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
    
    func setupRegisterButton(registerButton: UIButton, inputsView: UIView) {
        /* need x, y, width, height contraints */
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
// HANDLE ACTIONS -- DOES THIS GO INTO MODEL???
    
    //ACTION: triggered by register button press
    // JUST trying to switch to a new view rn without entering data into firebase

    //    @objc func handleRegister(sender: UIButton!) {
//        print ("successfully entered handleRegister function")
//        let newViewController = LoginScreenController()
//        self.present(newViewController, animated: true)
//
//    }
    
    // registerButton action
    @objc func handleRegister(emailTextField: UITextView, passwordTextField: UITextView) {

        //Able to run when it's just emailTextField but crashes when you try to access the .text field
        print ("successfully entered handleRegister function")
        //print (emailTextField.text)
        
        // Ensure email and password are valid values
//        guard let email = emailTextField.text, let password = passwordTextField.text
//            else {
//                print("Form input is not valid")
//                return
//        }

        // Register User
//        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
//            if error != nil {
//                print("Error in creating account")
//                return
//            }
//            // Successful Authentication, now save user
//            /*Store user info, temporarily set fire db rules to true, by default both set to fault*/
//
//
//        })

        //Switch the view to the login screen after the data has been sent
        let newViewController = LoginScreenController()
        self.present(newViewController, animated: true)

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
