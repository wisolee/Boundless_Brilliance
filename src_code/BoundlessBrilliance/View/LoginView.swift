//
//  LoginView.swift
//  BoundlessBrilliance
//
//  Created by Adam on 10/18/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView{
    
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
        view.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    
    // subview - nameSeparatorView
    let passwordSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //     subview - LoginButton
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.setTitle("Login", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to LoginButton
        //        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    // subview - registerButton
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        button.setTitle("New to the app? Register here", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Add action to registerButton
        //        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
        return button
    }()
    
    
}
