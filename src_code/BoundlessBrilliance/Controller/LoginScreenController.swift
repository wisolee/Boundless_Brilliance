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

    

    
    // Main Display
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create variables
        let loginView = LoginView()
        let profileImageView = loginView.profileImageView
        let inputsView = loginView.inputsView
        let loginButton = loginView.loginButton
        let registerButton = loginView.registerButton
        let emailTextField = loginView.emailTextField
        let emailSeparatorView = loginView.emailSeparatorView
        let passwordTextField = loginView.passwordTextField
        let passwordSeparatorView = loginView.passwordSeparatorView
        
        /* Add subviews */
        view.addSubview(profileImageView)
        view.addSubview(inputsView)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
//        view.addSubview(profileImageView)
        
        view.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        setUpProfileImageView(profileImageView: profileImageView, inputsView: inputsView)
        setUpInputsView(inputsView: inputsView, emailTextField: emailTextField, emailSeparatorView: emailSeparatorView, passwordTextField: passwordTextField, passwordSeparatorView: passwordSeparatorView)
        setUpLoginButton(loginButton: loginButton, inputsView: inputsView)
        setUpRegisterButton(registerButton: registerButton, inputsView: inputsView, loginButton: loginButton)
    }
    
    func setUpProfileImageView(profileImageView: UIImageView, inputsView: UIView) {
        /* need x, y, width, height contraints */
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -12).isActive = true
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
        loginButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
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
