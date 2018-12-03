//
//  ExtensionUIColor.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 11/7/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

extension UIColor {
    
    // Convenient extension of UIColor, simplies initialization
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
