//
//  LaunchController.swift
//  BoundlessBrilliance
//
//  Created by Cassia Artanegara on 11/20/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

class LaunchController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let launchView = LaunchView()
        let iconImageView = launchView.iconImageView
        
        view.addSubview(iconImageView)
        view.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        setUpIconImageView(iconImageView: iconImageView)
    }
    
    func setUpIconImageView (iconImageView: UIImageView) {
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
}
