//
//  LaunchView.swift
//  BoundlessBrilliance
//
//  Created by Cassia Artanegara on 11/20/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import Foundation
import UIKit

class LaunchView: UIView {
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "boundlessbrilliance-vert-logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
}
