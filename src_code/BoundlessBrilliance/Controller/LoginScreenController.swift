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
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // subview - inputsContainerView
    let inputsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        // must set up this property otherwise, the specified anchors will not work
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // subview - nameTextField
    let emailTextField: UITextField = {
        let email_tf = UITextField()
        email_tf.placeholder = "Email"
        email_tf.translatesAutoresizingMaskIntoConstraints = false
        return email_tf
    }()
    
    // subview - nameSeparatorView
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // subview - nameTextField
    let passwordTextField: UITextField = {
        let password_tf = UITextField()
        password_tf.placeholder = "Password"
        password_tf.translatesAutoresizingMaskIntoConstraints = false
        password_tf.isSecureTextEntry = true
        return password_tf
    }()
    
    // subview - nameSeparatorView
    let passwordSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//     subview - LoginButton
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        button.setTitle("Login", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)

        // Add action to LoginButton
        //        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)

        return button
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
//        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    // Main Display
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 0, g: 128, b: 128);
        
        /* Add subviews */
        view.addSubview(profileImageView)
        view.addSubview(inputsView)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
        view.addSubview(profileImageView)
        
        setUpProfileImageView()
        setUpInputsView()
        setUpLoginButton()
        setUpRegisterButton()
    }
    
    func setUpProfileImageView() {
        /* need x, y, width, height contraints */
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    func setUpInputsView() {
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
        emailTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/4).isActive = true // 1/4 of entire height
        
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // emailTextField: need x, y, width, height contraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeparatorView.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/4).isActive = true // 1/4 of entire height
        
        // emailSeparatorView: need x, y, width, height contraints
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    func setUpLoginButton() {
        /* need x, y, width, height contraints */
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpRegisterButton() {
        /* need x, y, width, height contraints */
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
