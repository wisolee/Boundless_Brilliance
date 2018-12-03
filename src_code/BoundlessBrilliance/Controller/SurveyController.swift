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

class  SurveyController: UIViewController {
    
    var presentation: PresentationListItemModel? = nil
    let input_top_padding: CGFloat = 4
    let input_height: CGFloat = 40
    let input_left_padding: CGFloat = 5
    let input_header_padding: CGFloat = 12
    let input_section_header_padding: CGFloat = 20
    let sticker_options = ["", "yes", "no"]
    let shirt_options = ["", "yes", "no"]
    var shirt_sizes = ["", "extra-small", "small", "medium", "large", "extra-large"]
    
    // Section Header
    let header: UILabel! = {
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = UIColor(r: 0, g: 163, b: 173)
        $0.text = "Feedback Survey"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 30)
        return $0
    }(UILabel())
    
    // Title of presentation response questions
    let pres_section: UILabel! = {
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = UIColor(r: 0, g: 163, b: 173)
        $0.text = "Presentation"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 15)
        return $0
    }(UILabel())
    
    // Input: Number of students
    let num_students: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "How many students were there?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.keyboardType = UIKeyboardType.numberPad
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // Input: Science experiment performed
    let experiment: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "What experiment was performed?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // Input: Stickers yes/no
    let sticker_dropdown: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "Sticker?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // Input: T-shirt yes/no
    let shirt_dropdown: UITextField! = {
        $0.textColor = UIColor.black
        $0.placeholder = "T-Shirt?"
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textAlignment = NSTextAlignment.left
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // Input: T-shirt yes/no ? size
    let shirt_size_dropdown: UITextField! = {
        $0.placeholder = "Shirt Size"
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // Title of transportation question section
    let transportation_section: UILabel! = {
        $0.text = "Transportation"
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = UIColor(r: 0, g: 163, b: 173)
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 15)
        return $0
    }(UILabel())
    
    // Input: Driver/Rideshare caller
    let transportation_driver: UITextField! = {
        $0.placeholder = "Driver or caller of rideshare"
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // Input: Mileage
    let mileage_or_cost: UITextField! = {
        $0.placeholder = "Miles driven or cost of rideshare"
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextField())
    
    // Anecdote section header
    let anecdote_title: UILabel! = {
        $0.text = "Please leave any comments below"
        $0.adjustsFontSizeToFitWidth = true
        $0.textColor = UIColor(r: 0, g: 163, b: 173)
        $0.textAlignment = NSTextAlignment.left
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.font = .boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 15)
        return $0
    }(UILabel())
    
    // Input: Area where user inputs their anecdote
    let anecdote_view: UITextView = {
        $0.text = ""
        $0.textColor = UIColor.black
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.isEditable = true
        $0.font = .systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 15 : 13)
        return $0
    }(UITextView())
    
    // Button: on click, submits survey responses to Firebase storage
    let submit_button: UIButton = {
        $0.backgroundColor = UIColor(r: 0, g: 163, b: 173)
        $0.setTitle("Submit", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        $0.layer.cornerRadius = 5
        $0.addTarget(self, action: #selector(submit), for: .touchUpInside)
        return $0
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create variables
        let survey_view  = SurveyView()
        let inputs_view = survey_view.inputs_view
        let scroll_container = survey_view.scroll_container
        
        // Add the scrollContainer to the view and add the inputsview to the scrollContainer
        view.addSubview(scroll_container)
        scroll_container.addSubview(inputs_view)

        // Add all subview inputs and format them
        setupInputsView(inputs_view: inputs_view, scroll_view: scroll_container)
        
        // Load drop down spinners with data
        sticker_dropdown?.loadStickerShirtOptions(spinnerOptions: sticker_options)
        shirt_dropdown?.loadStickerShirtOptions(spinnerOptions: shirt_options)
        shirt_size_dropdown?.loadStickerShirtOptions(spinnerOptions: shirt_sizes)
        
        // Set background of view
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
    }
    
    // Formats scroll_view and inputs_view; adds input views to inputs_view
    func setupInputsView(inputs_view: UIView, scroll_view: UIScrollView) {
        // Format scroll_view
        scroll_view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scroll_view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        scroll_view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        scroll_view.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
      
        // Format inputs_view
        inputs_view.centerXAnchor.constraint(equalTo: scroll_view.centerXAnchor).isActive = true
        inputs_view.centerYAnchor.constraint(equalTo: scroll_view.centerYAnchor).isActive = true
        inputs_view.leadingAnchor.constraint(equalTo: scroll_view.leadingAnchor).isActive = true
        inputs_view.trailingAnchor.constraint(equalTo: scroll_view.trailingAnchor).isActive = true
        inputs_view.topAnchor.constraint(equalTo: scroll_view.topAnchor).isActive = true
        inputs_view.bottomAnchor.constraint(equalTo: scroll_view.bottomAnchor).isActive = true
        
        // Add header of the page
        inputs_view.addSubview(header)
        
        // Adding other input fields; separators follow each section, and they are initialized/formatted
        
        // Presentation section header
        inputs_view.addSubview(pres_section)
        
        let separator_0 = UIView()
        initSeparator(separator: separator_0)
        inputs_view.addSubview(separator_0)
        setupSeparator(emailSeparatorView: separator_0, inputsView: inputs_view, aboveView: pres_section)
        
        // Number of students present
        inputs_view.addSubview(num_students)
        
        let separator_1 = UIView()
        initSeparator(separator: separator_1)
        inputs_view.addSubview(separator_1)
        setupSeparator(emailSeparatorView: separator_1, inputsView: inputs_view, aboveView: num_students)
        
        // Science experiment performed
        inputs_view.addSubview(experiment)
        
        let separator_2 = UIView()
        initSeparator(separator: separator_2)
        inputs_view.addSubview(separator_2)
        setupSeparator(emailSeparatorView: separator_2, inputsView: inputs_view, aboveView: experiment)
        
        // Stickers needed?
        inputs_view.addSubview(sticker_dropdown)
        
        let separator_3 = UIView()
        initSeparator(separator: separator_3)
        inputs_view.addSubview(separator_3)
        setupSeparator(emailSeparatorView: separator_3, inputsView: inputs_view, aboveView: sticker_dropdown)
        
        // T-shirts needed and if so, what size
        inputs_view.addSubview(shirt_dropdown)
        inputs_view.addSubview(shirt_size_dropdown)
        
        let separator_4 = UIView()
        initSeparator(separator: separator_4)
        inputs_view.addSubview(separator_4)
        setupSeparator(emailSeparatorView: separator_4, inputsView: inputs_view, aboveView: shirt_dropdown)

        // Transportation section header
        inputs_view.addSubview(transportation_section)
        
        let separator_5 = UIView()
        initSeparator(separator: separator_5)
        inputs_view.addSubview(separator_5)
        setupSeparator(emailSeparatorView: separator_5, inputsView: inputs_view, aboveView: transportation_section)
        
        // Driver
        inputs_view.addSubview(transportation_driver)
        
        let separator_6 = UIView()
        initSeparator(separator: separator_6)
        inputs_view.addSubview(separator_6)
        setupSeparator(emailSeparatorView: separator_6, inputsView: inputs_view, aboveView: transportation_driver)
        
        // Mileage/cost
        inputs_view.addSubview(mileage_or_cost)
        
        let separator_7 = UIView()
        initSeparator(separator: separator_7)
        inputs_view.addSubview(separator_7)
        setupSeparator(emailSeparatorView: separator_7, inputsView: inputs_view, aboveView: mileage_or_cost)

        // Anecdote section header
        inputs_view.addSubview(anecdote_title)
        
        let separator_top = UIView()
        initSeparator(separator: separator_top)
        inputs_view.addSubview(separator_top)
        setupSeparator(emailSeparatorView: separator_top, inputsView: inputs_view, aboveView: anecdote_title)
        separator_top.topAnchor.constraint(equalTo: anecdote_title.bottomAnchor, constant: 12).isActive = true
        
        // Anecdote input
        inputs_view.addSubview(anecdote_view)

        let separator_bottom = UIView()
        initSeparator(separator: separator_bottom)
        inputs_view.addSubview(separator_bottom)
        setupSeparator(emailSeparatorView: separator_bottom, inputsView: inputs_view, aboveView: anecdote_view)
        
        let separator_left = UIView()
        initSeparator(separator: separator_left)
        inputs_view.addSubview(separator_left)
        setupVertLeftSeparator(emailSeparatorView: separator_left, inputsView: inputs_view, aboveView: separator_top, sideView: anecdote_view)
        
        let separator_right = UIView()
        initSeparator(separator: separator_right)
        inputs_view.addSubview(separator_right)
        setupVertRightSeparator(emailSeparatorView: separator_right, inputsView: inputs_view, aboveView: separator_top, sideView: anecdote_view)
        
        // Submit Button View
        inputs_view.addSubview(submit_button)
        
        // Format All Input Views
        initHeader(target: header, topView: inputs_view, container: inputs_view)
        
        // Reset top anchor of header since it is the first element of inputs_view
        header.topAnchor.constraint(equalTo: inputs_view.topAnchor, constant: 12).isActive = true
        
        initWideView(target: pres_section, topView: header, container: inputs_view)
        initWideView(target: num_students, topView: pres_section, container: inputs_view)
        initWideView(target: experiment, topView: num_students, container: inputs_view)
        initWideView(target: sticker_dropdown, topView: experiment, container: inputs_view)
        initSplitLeftView(target: shirt_dropdown, topView: sticker_dropdown, container: inputs_view)
        initSplitRightView(target: shirt_size_dropdown, topView: sticker_dropdown, container: inputs_view, leftView: shirt_dropdown)
        initSectionHeader(target: transportation_section, topView: shirt_size_dropdown, container: inputs_view)
        initWideView(target: transportation_driver, topView: transportation_section, container: inputs_view)
        initWideView(target: mileage_or_cost, topView: transportation_driver, container: inputs_view)
        initSectionHeader(target: anecdote_title, topView: mileage_or_cost, container: inputs_view)
        
        // Set up anecdote input section
        anecdote_view.topAnchor.constraint(equalTo: anecdote_title.bottomAnchor, constant: 6).isActive = true
        anecdote_view.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 2).isActive = true
        anecdote_view.widthAnchor.constraint(equalTo: inputs_view.widthAnchor, constant: -10).isActive = true
        anecdote_view.heightAnchor.constraint(equalToConstant: 200).isActive = true
       
        initSectionHeader(target: submit_button, topView: anecdote_view, container: inputs_view)
        submit_button.bottomAnchor.constraint(equalTo: inputs_view.bottomAnchor).isActive = true
        
        var content_rect = CGRect.zero
        
        for view in inputs_view.subviews {
            content_rect = content_rect.union(view.frame)
        }
    }
    
    func initHeader(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: input_header_padding).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: (input_left_padding * -1)).isActive = true
        target.heightAnchor.constraint(equalToConstant: input_height).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: input_left_padding).isActive = true
    }

    func initWideView(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: input_top_padding).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: (input_left_padding * -1)).isActive = true
        target.heightAnchor.constraint(equalToConstant: input_height).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: input_left_padding).isActive = true
    }
    
    func initSectionHeader(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: input_section_header_padding).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, constant: (input_left_padding * -1)).isActive = true
        target.heightAnchor.constraint(equalToConstant: input_height).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: input_left_padding).isActive = true
    }
    
    func initSplitLeftView(target: UIView, topView: UIView, container: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: input_top_padding).isActive = true
        target.leftAnchor.constraint(equalTo: container.leftAnchor, constant: input_left_padding).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: input_height).isActive = true
    }
    
    func initSplitRightView(target: UIView, topView: UIView, container: UIView, leftView: UIView) {
        target.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: input_top_padding).isActive = true
        target.leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: (input_left_padding * 2)).isActive = true
        target.widthAnchor.constraint(equalTo: container.widthAnchor, multiplier: 1/2, constant: -10).isActive = true
        target.heightAnchor.constraint(equalToConstant: input_height).isActive = true
    }

    func setupSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView) {
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    func setupVertLeftSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView, sideView: UIView) {
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func setupVertRightSeparator(emailSeparatorView: UIView, inputsView: UIView, aboveView: UIView, sideView: UIView) {
        emailSeparatorView.leftAnchor.constraint(equalTo: sideView.rightAnchor, constant: 7).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: aboveView.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalTo: sideView.heightAnchor, constant: 6).isActive = true
    }
    
    func initSeparator(separator: UIView) {
        separator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        separator.translatesAutoresizingMaskIntoConstraints = false
    }

    // When a user hits the submit button, app will attempt to download the csv file stored in Firebase storage to the app's internal storage, append a csv-formatted text string to the file, and then reupload it, replacing the old file.
    @objc func submit() {
        // Get a reference to the Firebase storage service
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storage_ref = storage.reference()
        
        // Create a reference to where the file will be downloaded locally
        let download = "download.text"

        // Create a reference to the file in Firebase/storage/surveys
        let survey_ref = storage_ref.child("surveys/file.txt")
        
        // String containing the information to be stored in the csv
        let text = "\(presentation!.date),\(presentation!.location),\(presentation!.names),\(presentation!.chapter),\(presentation!.time),\(num_students.text!),\(experiment.text!),\(sticker_dropdown.text!),\(shirt_dropdown.text!),\(shirt_size_dropdown.text!),\(transportation_driver.text!),\(mileage_or_cost.text!),\(anecdote_view.text!)\n"
        
        // If internal app storage is accessible, temporarily write file from Firebase to storage
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            // Create local filesystem URL
            let local_URL = dir.appendingPathComponent(download)
            
            // Attempt to download to the local filesystem
            _ = survey_ref.write(toFile: local_URL) { url, error in
                if error != nil {
                } else {
                    // Write text string to the downloaded file
                    do {
                        let file_handle = try FileHandle(forWritingTo: local_URL)
                        file_handle.seekToEndOfFile()
                        file_handle.write(text.data(using: .utf8)!)
                        file_handle.closeFile()
                    }
                    catch {
                        self.view.makeToast("There seemed to be an error while submitting your response. Please try again later.")
                    }
                    
                    // Reupload the file to Firebase storage
                    _ = survey_ref.putFile(from: local_URL, metadata: nil) { metadata, error in
                        guard metadata != nil
                            else {
                            return
                        }
                        
                        // Return back to previous view
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
    }
}
