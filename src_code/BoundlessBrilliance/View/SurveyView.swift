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
    let inputsView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = UIColor.blue
        //        view. = true
        // must set up this property otherwise, the specified anchors will not work
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
}

// subview - nameSeparatorView
//let SeparatorLine: UIView = {
//    let view = UIView()
//    view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
//    view.translatesAutoresizingMaskIntoConstraints = false
//    return view
//}()
//
//extension UITextField {
//    func loadStickerShirtOptions(spinnerOptions: [String]) {
//        self.inputView = SpinnerView(spinnerOptions: spinnerOptions, spinnerTextField: self)
//    }
//}
