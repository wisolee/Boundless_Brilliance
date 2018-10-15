//
//  LoginController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/14/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    // subview - inputsContainerView
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        // must set up this property otherwise, the specified anchors will not work
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // subview - loginButton
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Login", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    // subview - emailTextField
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - emailSeparatorView
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // subview - passwordTextField
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    // subview - profileImage
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // Main Display
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151);
        
        /* Add subviews */
        view.addSubview(inputsContainerView)
        view.addSubview(loginButton)
        view.addSubview(profileImageView)
        
        setUpInputsContainerView()
        setupLoginRegisterButton()
        setupProfileImageView()
    }
    
    func setupProfileImageView() {
        /* need x, y, width, height contraints */
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    func setUpInputsContainerView() {
        /* need x, y, width, height contraints */
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        /* adding placeholder subviews */
        inputsContainerView.addSubview(emailTextField)
        inputsContainerView.addSubview(emailSeparatorView)
        inputsContainerView.addSubview(passwordTextField)
        
        // emailTextField: need x, y, width, height contraints
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true // 1/2 of entire height
        
        // emailSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // passwordTextField: need x, y, width, height contraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/2).isActive = true // 1/2 of entire height
        
    }
    
    func setupLoginRegisterButton() {
        /* need x, y, width, height contraints */
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
