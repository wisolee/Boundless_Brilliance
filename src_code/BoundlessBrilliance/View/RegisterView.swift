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
//        imageView.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return imageView
    }()
    
//    let genSeparatorView: UIView = {
//        let sepView = UIView()
//        sepView.backgroundColor = UIColor(r: 0, g: 225, b: 225)
//        sepView.translatesAutoresizingMaskIntoConstraints = false
//        return sepView
//    }()
    
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

    
    // subview - emailSeparatorView
    let emailSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    // subview - passwordSeparatorView
    let passwordSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // subview - passwordSeparatorView
    let chapterSeparatorView: UIView = {
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
