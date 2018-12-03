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
    
    // Displays the logo on the register page
    let profile_image_view: UIImageView = {
        let image_view = UIImageView()
        image_view.image = UIImage(named: "boundlessbrilliance-vert-logo")
        image_view.translatesAutoresizingMaskIntoConstraints = false
        image_view.contentMode = .scaleAspectFill
        return image_view
    }()
    
    // Sets up the inputs view for the form to register
    let inputs_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // Subviews below are added as a subview of inputsView
    
    // Sets up a separator
    let name_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Sets up the email text field
    let email_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // Sets up a separator
    let password_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Sets up a chapter text field
    let chapter_separator_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
}

// Creates instance for spinner options for chapters
extension UITextField {
    func loadChapterOptions(spinnerOptions: [String]) {
        self.inputView = SpinnerView(spinnerOptions: spinnerOptions, spinnerTextField: self)
    }
}

// Creates an instance for spinner options for member types
extension UITextField {
    func loadMemberTypeOptions(spinnerOptions: [String]) {
        self.inputView = SpinnerView(spinnerOptions: spinnerOptions, spinnerTextField: self)
    }
}
