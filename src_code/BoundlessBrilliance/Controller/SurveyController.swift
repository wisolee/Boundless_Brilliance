//
//  SurveyController.swift
//  BoundlessBrilliance
//
//  Created by Adam on 11/21/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import Foundation
import UIKit
import GoogleAPIClientForREST
import Firebase

class  SurveyController : UIViewController {
    
    var presentation:PresentationListItemModel? = nil
    let ScrollViewHeight = 1410
    let INPUT_TOP_PADDING = 4
    let stickerOptions = ["", "yes", "no"]
    let shirtOptions = ["", "yes", "no"]
    var shirtSizes = ["", "extra-small", "small", "medium", "large", "extra-large"]
    
    let presSection: UILabel! = {
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = UIColor(r: 0, g: 128, b: 128)
        $0.text = "Presentation"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 15)
        return $0
    }(UILabel())
    
    // number of students
    let NumStudents: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "How many students were there?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.keyboardType = UIKeyboardType.numberPad
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // science experiment performed
    let Experiment: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "What experiment was performed?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // stickers yes/no
    let StickerDropdown: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "Sticker?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // t-shirt yes/no ? size
    let ShirtDropdown: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "T-Shirt?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // t-shirt yes/no ? size
    let ShirtSizeDropdown: UITextField! = {
        $0.placeholder = "Shirt Size"
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    let transportationSection: UILabel! = {
        $0.text = "Transportation"
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = UIColor(r: 0, g: 128, b: 128)
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 15)
        return $0
    }(UILabel())
    
    let transportationDriver: UITextField! = {
        $0.placeholder = "Driver or caller of rideshare"
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    let mileageOrCost: UITextField! = {
        $0.placeholder = "Miles driven or cost of rideshare"
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    let AnecdoteTitle: UILabel! = {
        $0.text = "Please leave any comments below"
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = UIColor(r: 0, g: 128, b: 128)
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 15)
        return $0
    }(UILabel())
    
    let AnecdoteView: UITextView = {
        $0.text = ""
        $0.textColor = UIColor.black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.isEditable = true
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    let SubmitButton: UIButton = {
        $0.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        $0.setTitle("Submit", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 5
        // Add action to registerButton
        $0.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create variables
        let surveyView  = SurveyView()
        let inputsView = surveyView.inputsView
        let scrollContainer = surveyView.scrollContainer
        
        // Add the scrollContainer to the view and add the inputsview to the scrollContainer
        view.addSubview(scrollContainer)
        scrollContainer.addSubview(inputsView)

        setupInputsView(inputsView: inputsView, scrollView: scrollContainer)
        StickerDropdown?.loadStickerShirtOptions(spinnerOptions: stickerOptions)
        ShirtDropdown?.loadStickerShirtOptions(spinnerOptions: shirtOptions)
        ShirtSizeDropdown?.loadStickerShirtOptions(spinnerOptions: shirtSizes)
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
    }

    func setupInputsView(inputsView: UIView, scrollView: UIScrollView){
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        scrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
      
        inputsView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
        inputsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        inputsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        inputsView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        inputsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        // Presentation Inputs
        inputsView.addSubview(presSection)
        let separator0 = UIView()
        initSeparator(separator: separator0)
        inputsView.addSubview(separator0)
        setupSeparator(emailSeparatorView: separator0, inputsView: inputsView, aboveView: presSection)
        
        
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

        // Transportation Input Views
        inputsView.addSubview(transportationSection)
        
        let separator5 = UIView()
        initSeparator(separator: separator5)
        inputsView.addSubview(separator5)
        setupSeparator(emailSeparatorView: separator5, inputsView: inputsView, aboveView: transportationSection)
        
        inputsView.addSubview(transportationDriver)
        
        let separator6 = UIView()
        initSeparator(separator: separator6)
        inputsView.addSubview(separator6)
        setupSeparator(emailSeparatorView: separator6, inputsView: inputsView, aboveView: transportationDriver)
        
        
        inputsView.addSubview(mileageOrCost)
        
        let separator7 = UIView()
        initSeparator(separator: separator7)
        inputsView.addSubview(separator7)
        setupSeparator(emailSeparatorView: separator7, inputsView: inputsView, aboveView: mileageOrCost)

        
        // Anecdote Input Views
        inputsView.addSubview(AnecdoteTitle)
        
        let separatorT = UIView()
        initSeparator(separator: separatorT)
        inputsView.addSubview(separatorT)
        setupSeparator(emailSeparatorView: separatorT, inputsView: inputsView, aboveView: AnecdoteTitle)
        separatorT.topAnchor.constraint(equalTo: AnecdoteTitle.bottomAnchor, constant: 12).isActive = true
        inputsView.addSubview(AnecdoteView)

        let separatorB = UIView()
        initSeparator(separator: separatorB)
        inputsView.addSubview(separatorB)
        setupSeparator(emailSeparatorView: separatorB, inputsView: inputsView, aboveView: AnecdoteView)
        
        let separatorLeft = UIView()
        initSeparator(separator: separatorLeft)
        inputsView.addSubview(separatorLeft)
        setupVertLeftSeparator(emailSeparatorView: separatorLeft, inputsView: inputsView, aboveView: separatorT, sideView: AnecdoteView)
        
        let separatorRight = UIView()
        initSeparator(separator: separatorRight)
        inputsView.addSubview(separatorRight)
        setupVertRightSeparator(emailSeparatorView: separatorRight, inputsView: inputsView, aboveView: separatorT, sideView: AnecdoteView)
        
        
        // Submit Button View
        inputsView.addSubview(SubmitButton)
        
        // Format All Input Views
        initWideView(target: presSection, topView: inputsView, container: inputsView)
        presSection.topAnchor.constraint(equalTo: inputsView.topAnchor, constant: 6).isActive = true
        initWideView(target: NumStudents, topView: presSection, container: inputsView)
        initWideView(target: Experiment, topView: NumStudents, container: inputsView)
        initWideView(target: StickerDropdown, topView: Experiment, container: inputsView)
        initSplitLeftView(target: ShirtDropdown, topView: StickerDropdown, container: inputsView)
        initSplitRightView(target: ShirtSizeDropdown, topView: StickerDropdown, container: inputsView, leftView: ShirtDropdown)
        initSectionHeader(target: transportationSection, topView: ShirtSizeDropdown, container: inputsView)
        initWideView(target: transportationDriver, topView: transportationSection, container: inputsView)
        initWideView(target: mileageOrCost, topView: transportationDriver, container: inputsView)
        initSectionHeader(target: AnecdoteTitle, topView: mileageOrCost, container: inputsView)
        AnecdoteView.topAnchor.constraint(equalTo: AnecdoteTitle.bottomAnchor, constant: 6).isActive = true
        AnecdoteView.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 2).isActive = true
        AnecdoteView.widthAnchor.constraint(equalTo: inputsView.widthAnchor, constant: -10).isActive = true
        AnecdoteView.heightAnchor.constraint(equalToConstant: 200).isActive = true
       
        initSectionHeader(target: SubmitButton, topView: AnecdoteView, container: inputsView)
        SubmitButton.bottomAnchor.constraint(equalTo: inputsView.bottomAnchor).isActive = true
        
        var contentRect = CGRect.zero
        
        for view in inputsView.subviews {
            contentRect = contentRect.union(view.frame)
        }
    }
    

    func initWideView(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: CGFloat(INPUT_TOP_PADDING)).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: -5).isActive = true
        target.heightAnchor.constraint(equalToConstant: 40).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 5).isActive = true
    }
    
    func initSectionHeader(target: UIView, topView: UIView, container: UIView){
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
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

    func setupSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView){
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupVertLeftSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView, sideView: UIView){
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func setupVertRightSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView, sideView: UIView){
        emailSeparatorView.leftAnchor.constraint(equalTo: sideView.rightAnchor, constant: 7).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func initSeparator(separator: UIView){
        separator.backgroundColor = UIColor.lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
    }

    
    @objc func submit(){
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        let download = "download.text"

        // Create a child reference
        let surveyRef = storageRef.child("surveys/file.txt")
        
        //date, location, names, chapter, time, number of students,
        
        let text = "\(presentation!.date),\(presentation!.location),\(presentation!.names),\(presentation!.chapter),\(presentation!.time),\(NumStudents.text!),\(Experiment.text!),\(StickerDropdown.text!),\(ShirtDropdown.text!),\(ShirtSizeDropdown.text!),\(transportationDriver.text!),\(mileageOrCost.text!),\(AnecdoteView.text!)\n" //just a text
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            // Create local filesystem URL
            let localURL = dir.appendingPathComponent(download)
            
            // Download to the local filesystem
            let downloadTask = surveyRef.write(toFile: localURL) { url, error in
                if let error = error {
                } else {
                    //writing
                    do {
                        let fileHandle = try FileHandle(forWritingTo: localURL)
                        fileHandle.seekToEndOfFile()
                        fileHandle.write(text.data(using: .utf8)!)
                        fileHandle.closeFile()
                    }
                    catch {/* error handling here */}
                    
                    //reading
                    do {
                        let text2 = try String(contentsOf: localURL, encoding: .utf8)
                        print("Here are the contents: \(text2)")
                    }
                    catch {/* error handling here */}
                    
                    // Upload the file to the path "images/rivers.jpg"
                    let uploadTask = surveyRef.putFile(from: localURL, metadata: nil) { metadata, error in
                        guard let metadata = metadata
                            else {
                            return
                        }
//                        let detail = PresentationDetailController()
//                        detail.presentation = self.presentation
//                        detail.detailToast()
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
