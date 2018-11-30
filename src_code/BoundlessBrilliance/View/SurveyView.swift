//
//  SurveyView.swift
//  BoundlessBrilliance
//
//  Created by Adam on 11/21/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import Foundation
import UIKit

class SurveyView : UIView{
    
    // subview - inputsContainerView
    let scrollContainer: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.white
        // must set up this property otherwise, the specified anchors will not work
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    // subview - inputsContainerView
    let inputsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        // must set up this property otherwise, the specified anchors will not work
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()

}
