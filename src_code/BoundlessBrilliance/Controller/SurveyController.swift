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
    
    let presSection: UITextView! = {
        let ns = UITextView()
        ns.isEditable = false
        ns.textColor = UIColor(r: 0, g: 240, b: 240)
        ns.text = "Presentation"
        ns.translatesAutoresizingMaskIntoConstraints = false
        ns.textAlignment = NSTextAlignment.left
        ns.backgroundColor = UIColor.white
        ns.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return ns
    }()
    
    //number of students
    let NumStudents: UITextField! = {
        let ns = UITextField()
        ns.textColor = UIColor.black
        ns.placeholder = "How many students were there?"
        ns.translatesAutoresizingMaskIntoConstraints = false
        ns.textAlignment = NSTextAlignment.center
        ns.keyboardType = UIKeyboardType.numberPad
        ns.borderStyle = UITextField.BorderStyle.line
        ns.backgroundColor = UIColor.white
        ns.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return ns
    }()
    
    //science experiment performed
    let Experiment: UITextField! = {
        let exp = UITextField()
        exp.textColor = UIColor.black
        exp.placeholder = "What experiment was performed?"
        exp.translatesAutoresizingMaskIntoConstraints = false
        exp.textAlignment = NSTextAlignment.center
        exp.borderStyle = UITextField.BorderStyle.line
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
    
    let transportationSection: UITextView! = {
        let tf = UITextView()
        tf.text = "Transportation"
        tf.isEditable = false
        tf.textColor = UIColor(r: 0, g: 240, b: 240)
        tf.textAlignment = NSTextAlignment.left
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.white
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return tf
    }()
    
    let transportationDriver: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Driver or caller of rideshare"
        tf.textAlignment = NSTextAlignment.center
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.white
        tf.borderStyle = UITextField.BorderStyle.line
        tf.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return tf
    }()
    
    let mileageOrCost: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "Miles driven or cost of rideshare"
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
        
    }

    func setupInputsView(inputsView: UIScrollView){
        
        /* inputsView: need x, y, width, height contraints */
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 4/5).isActive = true
        
        inputsView.addSubview(presSection)
        let separator0 = UIView()
        initSeparator(separator: separator0)
        inputsView.addSubview(separator0)
        setupSeparator(emailSeparatorView: separator0, inputsView: inputsView, aboveView: presSection)
        
        inputsView.addSubview(NumStudents)
        inputsView.addSubview(Experiment)
        inputsView.addSubview(StickerDropdown)
        inputsView.addSubview(ShirtDropdown)
        inputsView.addSubview(ShirtSizeDropdown)

        let separator4 = UIView()
        initSeparator(separator: separator4)
        inputsView.addSubview(separator4)
        setupSeparator(emailSeparatorView: separator4, inputsView: inputsView, aboveView: ShirtDropdown)

        inputsView.addSubview(AnecdoteView)

        let separator5 = UIView()
        initSeparator(separator: separator5)
        inputsView.addSubview(separator5)
        setupSeparator(emailSeparatorView: separator5, inputsView: inputsView, aboveView: AnecdoteView)
        
        let separatorLeft = UIView()
        initSeparator(separator: separatorLeft)
        inputsView.addSubview(separatorLeft)
        setupVertLeftSeparator(emailSeparatorView: separatorLeft, inputsView: inputsView, aboveView: separator4, sideView: AnecdoteView)
        
        let separatorRight = UIView()
        initSeparator(separator: separatorRight)
        inputsView.addSubview(separatorRight)
        setupVertRightSeparator(emailSeparatorView: separatorRight, inputsView: inputsView, aboveView: separator4, sideView: AnecdoteView)
        
        inputsView.addSubview(transportationSection)
        
        let separator6 = UIView()
        initSeparator(separator: separator6)
        inputsView.addSubview(separator6)
        setupSeparator(emailSeparatorView: separator6, inputsView: inputsView, aboveView: transportationSection)
        
        inputsView.addSubview(transportationDriver)
        inputsView.addSubview(mileageOrCost)
        
        
        initWideView(target: presSection, topView: inputsView, container: inputsView)
        presSection.topAnchor.constraint(equalTo: inputsView.topAnchor, constant: 6).isActive = true
        initWideView(target: NumStudents, topView: presSection, container: inputsView)
        initWideView(target: Experiment, topView: NumStudents, container: inputsView)
        initWideView(target: StickerDropdown, topView: Experiment, container: inputsView)
        initSplitLeftView(target: ShirtDropdown, topView: StickerDropdown, container: inputsView)
        initSplitRightView(target: ShirtSizeDropdown, topView: StickerDropdown, container: inputsView, leftView: ShirtDropdown)
        
        AnecdoteView.topAnchor.constraint(equalTo: ShirtSizeDropdown.bottomAnchor, constant: 6).isActive = true
        AnecdoteView.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 2).isActive = true
        AnecdoteView.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -10).isActive = true
        AnecdoteView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        initWideView(target: transportationSection, topView: AnecdoteView, container: inputsView)
        initWideView(target: transportationDriver, topView: transportationSection, container: inputsView)
        initWideView(target: mileageOrCost, topView: transportationDriver, container: inputsView)
        
        inputsView.contentSize = CGSize(width: inputsView.frame.width, height: CGFloat(1500))
    }

    func initWideView(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -5).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
    }
    
    func initSplitLeftView(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initSplitRightView(target: UIView, topView: UIView, container: UIView, leftView: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 6).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: 10).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    func setupSeparator(emailSeparatorView: UIView, inputsView: UIScrollView, aboveView: UIView){
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor, constant: 3).isActive = true
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
    
    func setupVertRightSeparator(emailSeparatorView: UIView, inputsView: UIScrollView, aboveView: UIView, sideView: UIView){
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
