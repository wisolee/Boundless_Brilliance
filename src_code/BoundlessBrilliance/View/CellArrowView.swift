//
//  CellArrayView.swift
//  BoundlessBrilliance
//
//  Created by Adam on 11/23/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import Foundation
import UIKit

class CellArrow: UIView {
    
    // Draws the arrow on the presentation list view
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor(r: 232, g: 115, b: 0).cgColor)
            context.setLineWidth(1)
            context.move(to: CGPoint(x: 0, y: bounds.height * 2 / 3))
            context.addLine(to: CGPoint(x: bounds.width - 3, y: bounds.height / 2))
            context.strokePath()
            context.move(to: CGPoint(x: bounds.width - 3, y: bounds.height / 2))
            context.addLine(to: CGPoint(x: 0, y: bounds.height / 3))
            context.strokePath()
        }
    }
}
