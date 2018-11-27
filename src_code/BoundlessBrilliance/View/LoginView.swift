//
//  LoginView.swift
//  BoundlessBrilliance
//
//  Created by Adam on 10/18/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import Foundation
import UIKit

class LoginView: UIView {
    
    let profile_image_view: UIImageView = {
        let image_view = UIImageView()
        image_view.image = UIImage(named: "boundlessbrilliance-vert-logo")
        image_view.translatesAutoresizingMaskIntoConstraints = false
        image_view.contentMode = .scaleAspectFill
        return image_view
    }()
    
    // subview - inputsContainerView
    let inputs_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        // must set up this property otherwise, the specified anchors will not work
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    

    // subview - nameSeparatorView
    let email_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    // subview - nameSeparatorView
    let password_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    //     subview - login_button
    let login_button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        button.setTitle("Login", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        return button
    }()
    
    // subview - register_button
    let register_button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.setTitle("New to the app? Register here", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 0, g: 128, b: 128), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    


}
