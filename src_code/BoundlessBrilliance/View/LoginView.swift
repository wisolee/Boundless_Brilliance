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
    
    // Initialize logo image
    let profile_image_view: UIImageView = {
        let image_view = UIImageView()
        image_view.image = UIImage(named: "boundlessbrilliance-vert-logo")
        image_view.translatesAutoresizingMaskIntoConstraints = false
        image_view.contentMode = .scaleAspectFill
        return image_view
    }()
    
    // Set up container view for input fields
    let inputs_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        
        // Must set up this property otherwise, the specified anchors will not work
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // Set up email separator view
    let email_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Set up password separator view
    let password_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}
