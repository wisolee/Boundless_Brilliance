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
    

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "boundlessbrilliance-vert-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
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
    
    //SUBVIEWS BELOW ARE ADDED AS A SUBVIEW OF inputsView
    
    // subview - nameTextField
    let nameTextField: UITextField = {
        let name_tf = UITextField()
        name_tf.placeholder = "Name"
        name_tf.translatesAutoresizingMaskIntoConstraints = false
        return name_tf
    }()
    
    // subview - nameSeparatorView
    let nameSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    // subview - emailTextField
//    let emailTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "email"
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        return tf
//    }()
    
    // subview - emailSeparatorView
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    // subview - passwordTextField
//    let passwordTextField: UITextField = {
//        let tf = UITextField()
//        tf.placeholder = "password"
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        return tf
//    }()
    
    // subview - passwordSeparatorView
    let passwordSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    // subview - chapterTextField
//    let chapterTextField: UITextField! = {
//        let tf = UITextField()
//        tf.placeholder = "chapter"
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        return tf
//    }()
    
}

extension UITextField {
    func loadSpinnerOptions(spinnerOptions: [String]) {
        self.inputView = SpinnerView(spinnerOptions: spinnerOptions, spinnerTextField: self)
    }
}
