//
//  SurveyView.swift
//  BoundlessBrilliance
//
//  Created by Adam on 11/21/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import Foundation
import UIKit

class SurveyView : UIView {
    
    // Allows content to be scrollable
    let scroll_container: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
    
    // Will be added to scroll_container; will contain all the input fields
    let inputs_view: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        return view
    }()
}
