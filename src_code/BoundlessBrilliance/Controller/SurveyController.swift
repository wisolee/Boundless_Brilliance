//
//  SurveyController.swift
//  BoundlessBrilliance
//
//  Created by Adam on 11/21/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import Foundation
import UIKit

class  SurveyController : UIViewController {
    var presentation:PresentationListItemModel? = nil
    let ScrollViewHeight = 1500
    let stickerOptions = ["", "yes", "no"]
    let shirtOptions = ["", "yes", "no"]
    var shirtSizes = ["", "extra-small", "small", "medium", "large", "extra-large"]
    
    //number of students
    let NumStudents: UITextField! = {
        let ns = UITextField()
        ns.textColor = UIColor.black
        ns.placeholder = "# students?"
        ns.translatesAutoresizingMaskIntoConstraints = false
        ns.textAlignment = NSTextAlignment.center
        ns.backgroundColor = UIColor.white
        ns.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return ns
    }()
    
    //science experiment performed
    let Experiment: UITextField! = {
        let exp = UITextField()
        exp.textColor = UIColor.black
        exp.text = "Experiment Performed"
        exp.translatesAutoresizingMaskIntoConstraints = false
        exp.textAlignment = NSTextAlignment.right
        exp.backgroundColor = UIColor.white
        exp.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return exp
    }()
    
    //stickers yes/no
    let StickerDropdown: UITextField! = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.placeholder = "Sticker?"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = NSTextAlignment.center
        tf.backgroundColor = UIColor.white
        tf.borderStyle = UITextField.BorderStyle.line
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return tf
    }()
    
    // t-shirt yes/no ? size
    let ShirtDropdown: UITextField! = {
        let tf = UITextField()
        tf.textColor = UIColor.black
        tf.placeholder = "T-Shirt?"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = NSTextAlignment.center
        tf.backgroundColor = UIColor.white
        tf.borderStyle = UITextField.BorderStyle.line
        //        tf.borderStyle
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return tf
    }()
    
    // t-shirt yes/no ? size
    let ShirtSizeDropdown: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Shirt Size"
        tf.textAlignment = NSTextAlignment.center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.white
        tf.borderStyle = UITextField.BorderStyle.line
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return tf
    }()
    
    let AnecdoteView: UITextView = {
        let af_tv = UITextView()
        af_tv.text = "Any anecdotes to share?"
        af_tv.textColor = UIColor.black
        af_tv.translatesAutoresizingMaskIntoConstraints = false
        af_tv.backgroundColor = UIColor.white
        af_tv.isEditable = true
        af_tv.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return af_tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create variables
        let surveyView  = SurveyView()
        let inputsView = surveyView.inputsView
        
        /* Add subviews */
        view.addSubview(inputsView)
        setupInputsView(inputsView: inputsView)
        StickerDropdown?.loadStickerShirtOptions(spinnerOptions: stickerOptions)
        ShirtDropdown?.loadStickerShirtOptions(spinnerOptions: shirtOptions)
        ShirtSizeDropdown?.loadStickerShirtOptions(spinnerOptions: shirtSizes)
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        
        
//        super.viewDidLoad()
//        //create variables
//        let presDetailView  = PresentationDetailView()
//        let inputsView = presDetailView.inputsView
//
//        /* Add subviews */
//        view.addSubview(inputsView)
//        LocField.text = presentation?.location
//        NamesField.text = presentation?.names
//        setupInputsView(inputsView: inputsView, textField: TestTextField, locField: LocField, namesField: NamesField, anecdoteField: AnecdoteView)
//        StickerDropdown?.loadStickerShirtOptions(spinnerOptions: stickerOptions)
//        ShirtDropdown?.loadStickerShirtOptions(spinnerOptions: shirtOptions)
//        ShirtSizeDropdown?.loadStickerShirtOptions(spinnerOptions: shirtSizes)
//        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
//
    }

    func setupInputsView(inputsView: UIScrollView){
        inputsView.addSubview(NumStudents)
        let separator1 = UIView()
        
        initSeparator(separator: separator1)
        inputsView.addSubview(separator1)
        setupSeparator(emailSeparatorView: separator1, inputsView: inputsView, aboveView: NumStudents)
        
        inputsView.addSubview(Experiment)
        
        let separator2 = UIView()
        initSeparator(separator: separator2)
        inputsView.addSubview(separator2)
        setupSeparator(emailSeparatorView: separator2, inputsView: inputsView, aboveView: Experiment)
        
        inputsView.addSubview(StickerDropdown)
        
        let separator3 = UIView()
        initSeparator(separator: separator3)
        inputsView.addSubview(separator3)
        setupSeparator(emailSeparatorView: separator3, inputsView: inputsView, aboveView: StickerDropdown)
        
        inputsView.addSubview(ShirtDropdown)
        inputsView.addSubview(ShirtSizeDropdown)
        
        let separator4 = UIView()
        initSeparator(separator: separator4)
        inputsView.addSubview(separator4)
        setupSeparator(emailSeparatorView: separator4, inputsView: inputsView, aboveView: ShirtDropdown)
        
        inputsView.addSubview(AnecdoteView)
        
        let bottomLine = UIView()
        initSeparator(separator: bottomLine)
        inputsView.addSubview(bottomLine)
        setupSeparator(emailSeparatorView: bottomLine, inputsView: inputsView, aboveView: AnecdoteView)
        
        NumStudents.topAnchor.constraint(equalTo: inputsView.topAnchor, constant: 6).isActive = true
        NumStudents.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2).isActive = true
        NumStudents.heightAnchor.constraint(equalToConstant: 40).isActive = true
        NumStudents.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 15).isActive = true
        
        Experiment.topAnchor.constraint(equalTo: NumStudents.bottomAnchor, constant: 6).isActive = true
        Experiment.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        Experiment.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        StickerDropdown.topAnchor.constraint(equalTo: Experiment.bottomAnchor, constant: 6).isActive = true
        StickerDropdown.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        StickerDropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        ShirtDropdown.topAnchor.constraint(equalTo: StickerDropdown.bottomAnchor, constant: 6).isActive = true
        ShirtDropdown.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 5).isActive = true
        ShirtDropdown.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        ShirtDropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        ShirtSizeDropdown.topAnchor.constraint(equalTo: StickerDropdown.bottomAnchor, constant: 6).isActive = true
        ShirtSizeDropdown.leftAnchor.constraint(equalTo: ShirtDropdown.rightAnchor, constant: 10).isActive = true
        ShirtSizeDropdown.widthAnchor.constraint(equalTo: inputsView.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        ShirtSizeDropdown.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        AnecdoteView.topAnchor.constraint(equalTo: ShirtSizeDropdown.bottomAnchor, constant: 6).isActive = true
        AnecdoteView.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 2).isActive = true
        AnecdoteView.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -10).isActive = true
        AnecdoteView.heightAnchor.constraint(equalToConstant: 200).isActive = true
       
//        setScrollViewSize(inputsView: inputsView)
        inputsView.contentSize = CGSize(width: inputsView.frame.width, height: CGFloat(1500))
    }
    
//    func setScrollViewSize(inputsView: UIScrollView){
////        var height: CGFloat = 0
////        for view in inputsView.subviews {
////            print("subview height: \(view.frame.size.height)")
////            print("scrollview height: \(height)")
////            
////            height = height + view.bounds.size.height
////        }
//
//        inputsView.contentSize = CGSize(width: inputsView.frame.width, height: CGFloat(ScrollViewHeight))
//    }

    func setupSeparator(emailSeparatorView: UIView, inputsView: UIScrollView, aboveView: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupVertLeftSeparator(emailSeparatorView: UIView, inputsView: UIScrollView, aboveView: UIView, sideView: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func setupVertRightSeparator(emailSeparatorView: UIView, inputsView: UIScrollView, aboveView: UIView, sideView: UIView, otherSeparator: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: sideView.rightAnchor, constant: 7).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func initSeparator(separator: UIView){
        separator.backgroundColor = UIColor.gray
        separator.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
