//
//  RegisterView.swift
//  BoundlessBrilliance
//
//  Created by Cassia Artanegara on 10/17/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

class RegisterView: UIView {
    
    let profile_image_view: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "boundlessbrilliance-vert-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
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
    
    //SUBVIEWS BELOW ARE ADDED AS A SUBVIEW OF inputsView
    

    // subview - nameTextField
    let name_text_field: UITextField = {
        let name_tf = UITextField()
        name_tf.placeholder = "Name"
        name_tf.translatesAutoresizingMaskIntoConstraints = false
        return name_tf
    }()
    
    // subview - nameSeparatorView
    let name_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // subview - emailSeparatorView
    let email_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // subview - passwordSeparatorView
    let password_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // subview - passwordSeparatorView
    let chapter_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

extension UITextField {
    func loadChapterOptions(spinnerOptions: [String]) {
        self.inputView = SpinnerView(spinnerOptions: spinnerOptions, spinnerTextField: self)
    }
}

extension UITextField {
    func loadMemberTypeOptions(spinnerOptions: [String]) {
        self.inputView = SpinnerView(spinnerOptions: spinnerOptions, spinnerTextField: self)
    }
}
