//
//  LoginScreenController.swift
//  BoundlessBrilliance
//
//  Created by Cora Monokandilos on 10/16/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

class LoginScreenController: UIViewController {

    
    //     subview - LoginButton
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        button.setTitle("Login", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to LoginButton
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)

        
        return button
    }()
    

    //action for loginButton -- authenticates user
    @objc func handleLogin() {
        
        guard let email = emailTextField.text, let password = passwordTextField.text
            else {
                print("Form input is not valid")
                return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.view.makeToast("User not found or incorrect password.")
                print("User or password not found")
                print(error as Any)
                return
            } else {
                print("Successfully authenticated user")
                print(user as Any)
                
                // After succesfully logging-in go to presentationList
                let chapterScheduleVC = PresentationListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
                self.navigationController?.pushViewController(chapterScheduleVC, animated: true)
            }
        }

    }
    
    
    // subview - registerButton
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.setTitle("New to the app? Register here", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 0, g: 128, b: 128), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to registerButton
        button.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)

        
        return button
    }()
    
    // subview - nameTextField
    let passwordTextField: UITextField = {
        let password_tf = UITextField()
        password_tf.placeholder = "Password"
        password_tf.translatesAutoresizingMaskIntoConstraints = false
        password_tf.isSecureTextEntry = true
        password_tf.autocapitalizationType = .none
        password_tf.autocorrectionType = .no
        return password_tf
    }()

    // subview - nameTextField
    let emailTextField: UITextField = {
        let email_tf = UITextField()
        email_tf.placeholder = "Email"
        email_tf.translatesAutoresizingMaskIntoConstraints = false
        return email_tf
    }()

    
    // registerButton action starts the register activity
    @objc func goToRegister() {
        // Ensure email and password are valid values
        let newViewController = RegisterController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
  
    // Main Display---------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //create variables
        let loginView = LoginView()
        let profileImageView = loginView.profileImageView
        let inputsView = loginView.inputsView
        let emailSeparatorView = loginView.emailSeparatorView
        let passwordSeparatorView = loginView.passwordSeparatorView
        
        /* Add subviews */
        view.addSubview(profileImageView)
        view.addSubview(inputsView)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
//        view.addSubview(profileImageView)
        
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        setUpProfileImageView(profileImageView: profileImageView, inputsView: inputsView)
        setUpInputsView(inputsView: inputsView, emailTextField: emailTextField, emailSeparatorView: emailSeparatorView, passwordTextField: passwordTextField, passwordSeparatorView: passwordSeparatorView)
        setUpLoginButton(loginButton: loginButton, inputsView: inputsView)
        setUpRegisterButton(registerButton: registerButton, inputsView: inputsView, loginButton: loginButton)
        
        
    }
    
    // Customize navigationBar
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.barTintColor = UIColor.white
//        self.navigationController?.navigationBar.tintColor = UIColor.white
//    }
    
    func setUpProfileImageView(profileImageView: UIImageView, inputsView: UIView) {
        /* need x, y, width, height contraints */
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    func setUpInputsView(inputsView: UIView, emailTextField: UITextField,
                        emailSeparatorView: UIView,
                        passwordTextField: UITextField,
                        passwordSeparatorView: UIView) {
        /* need x, y, width, height contraints */
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        /* adding placeholder subviews */
        inputsView.addSubview(emailTextField)
        inputsView.addSubview(emailSeparatorView)
        inputsView.addSubview(passwordTextField)
        inputsView.addSubview(passwordSeparatorView)
        
        // nameTextField: need x, y, width, height contraints
        emailTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2).isActive = true // 1/2 of entire height
        
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // emailTextField: need x, y, width, height contraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeparatorView.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2).isActive = true // 1/2 of entire height
        
        // emailSeparatorView: need x, y, width, height contraints
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    func setUpLoginButton(loginButton: UIButton, inputsView: UIView) {
        /* need x, y, width, height contraints */
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 30).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpRegisterButton(registerButton: UIButton, inputsView: UIView, loginButton: UIButton) {
        /* need x, y, width, height contraints */
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
