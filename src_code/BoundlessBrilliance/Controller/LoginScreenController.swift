//
//  LoginScreenController.swift
//  BoundlessBrilliance
//
//  Created by Cora Monokandilos on 10/16/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

// Global presenter variables
var presenter_chapter: String!
var presenter_name: String!
var presenter_member_type: String!

// Variable that waits for Firebase request to finish
let firebase_group = DispatchGroup()

// Global list of presentation models
var presentation_items: [PresentationListItemModel] = []
var filtered_presentation_items = [PresentationListItemModel]()

class LoginScreenController: UIViewController {
    
    
    // Show loading alert while data is retrieved
    func startLoadingAlert() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loading_indicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loading_indicator.hidesWhenStopped = true
        loading_indicator.style = UIActivityIndicatorView.Style.gray
        loading_indicator.startAnimating()
        alert.view.addSubview(loading_indicator)
        self.present(alert, animated: false, completion: nil)
    }
    
    // Retrieve data from Firebase
    func loadData() {
        let ref: DatabaseReference! = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
        let user_id = Auth.auth().currentUser!.uid
        let presentation_reference = ref.child("presentations")
        var presentation_dict: [String : Dictionary<String, Any>]!
        
        // Start Firebase snapshot
        firebase_group.enter()
        
        // Get presentation info and load into list
        _ = presentation_reference
            .observe(DataEventType.value, with: { (snapshot) in
                presentation_dict = snapshot.value as? [String : Dictionary] ?? [:]
                if (presentation_dict != nil){
                    self.loadDataIntoArray(presentation_dict: presentation_dict, ref: ref)
                }
            })
        
        // Get user info from login to filter presentations
        ref.child("users").child(user_id).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let chapter = value?["chapter"] as? String ?? ""
            let member_type = value?["memberType"] as? String ?? ""
            
            presenter_name = name
            presenter_chapter = chapter
            presenter_member_type = member_type
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // Loads data into presentation list
    func loadDataIntoArray(presentation_dict: [String : Dictionary<String, Any>], ref: DatabaseReference) {
        var presenter_dict: Dictionary<String, String>!
        var presentation_num = presentation_dict.count
        
        // Goes through all presentations in dictionary
        for presentation in presentation_dict.values {
            presenter_dict = presentation["Presenters"] as? Dictionary
            let parsed_presenter_string = parsePresenterDictionary(presenter_names: Array(presenter_dict.values))
            let date_string : String = presentation["Date"] as! String
            let formatted_date : String = parseDateTime(datetime : date_string).0
            let formatted_time: String = parseDateTime(datetime : date_string).1
            var presentation_chapter: String!
            
            retrieveChapter(presenter_dict: presenter_dict, ref: ref, completion: { message in
                // Callback from completion handler
                presentation_chapter = message
                if (presenter_member_type == "Presenter" || presenter_member_type == "Outreach Coordinator") {
                    // Only load presentations from the presenter's chapter
                    if  presenter_chapter == presentation_chapter {
                        presentation_items.append(PresentationListItemModel(location: presentation["Location"] as! String, room_number: presentation["RoomNumber"] as! NSNumber, names: parsed_presenter_string, chapter: presentation_chapter, time: formatted_time, date: formatted_date, teacher_name: presentation["TeacherName"] as! String, teacher_email: presentation["TeacherEmail"] as! String, grade: presentation["Grade"] as! NSNumber))
                    }
                } else {
                    // Load presentations from all chapters
                    presentation_items.append(PresentationListItemModel(location: presentation["Location"] as! String, room_number: presentation["RoomNumber"] as! NSNumber, names: parsed_presenter_string, chapter: presentation_chapter, time: formatted_time, date: formatted_date, teacher_name: presentation["TeacherName"] as! String, teacher_email: presentation["TeacherEmail"] as! String, grade: presentation["Grade"] as! NSNumber))
                }
                
                // Monitoring Firebase retrieval
                presentation_num -= 1
                if(presentation_num == 0){
                    firebase_group.leave()
                }
            })
        }
    }
    
    // Retrieve chapter associated with a presentation
    func retrieveChapter(presenter_dict: Dictionary<String, String>, ref: DatabaseReference, completion: @escaping (_ message: String) -> Void) {
        var presentation_chapter: String!
        
        // Obtain user_id from first presenter
        let first_user_id = Array(presenter_dict.keys)[0]
        ref.child("users").child(first_user_id).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user chapter field
            guard
                let value = snapshot.value as? NSDictionary,
                let chapter = value["chapter"]
                else {
                    completion("")
                    return
            }
            presentation_chapter = chapter as? String
            completion(presentation_chapter)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // Parse list of presenters and convert to one String
    func parsePresenterDictionary(presenter_names: Array<String>) -> String {
        var names_string: String = ""
        if (presenter_names.count == 1) {
            return presenter_names[0]
        } else if (presenter_names.count > 1) {
            var index = 0
            for name in presenter_names {
                names_string.append(contentsOf: name)
                if (index != presenter_names.count - 1){
                    names_string.append(contentsOf: ", ")
                }
                index += 1
            }
        } else {
            names_string = "No presenters listed."
        }
        return names_string
    }
    
    // Converts datetime string into separate date and time strings
    func parseDateTime(datetime : String) -> (String, String) {
        // Create expected date format from string
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "yyyyMMdd'T'HHmmss"
        
        // Create ISO Date object from datetime string
        let iso_datetime : Date! = date_formatter.date(from: datetime)
        
        // Call functions to correctly parse date and times for start and end of presentation
        let date_string = parseDate(iso_date: iso_datetime, date_formatter: date_formatter)
        let time_string = parseTime(iso_date: iso_datetime, date_formatter: date_formatter)
        return (date_string, time_string)
    }
    
    // Format date object into date string
    func parseDate(iso_date: Date, date_formatter: DateFormatter) -> String {
        // Create desired date format
        date_formatter.dateFormat = "yyyy-MM-dd"
        let date_string = date_formatter.string(from: iso_date)
        return date_string
    }
    
    // Format date object into time string
    func parseTime(iso_date: Date, date_formatter: DateFormatter) -> String {
        // Create desired time format
        date_formatter.dateFormat = "EEE hh:mm a"
        let time_string = date_formatter.string(from: iso_date)
        return time_string
    }
    
    // Login button initialization
    let login_button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 163, b: 173)
        button.setTitle("Login", for: .normal)
        
        // Must set up this property, otherwise the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to login button
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        return button
    }()
    
    // Action for login button -- checks user authentication
    @objc func handleLogin() {
        guard let email = email_text_field.text, let password = password_text_field.text
            else {
                print("Form input is not valid")
                return
        }
        
        // Set view controller for next page
        let presentation_view_controller = PresentationListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                // User login failed, print error message
                self.view.makeToast("User not found or incorrect password.")
                print("User or password not found")
                print(error as Any)
                return
            } else {
                // User login successful
                print("Successfully authenticated user")
                print(user as Any)
                
                // Show loading alert and start loading data
                self.startLoadingAlert()
                self.loadData()
                
                firebase_group.notify(queue: .main) {
                    // When Firebase requests are complete, dismiss alert
                    // and move to presentation collection view screen
                    presentation_items.sort { $0.date < $1.date }
                    self.dismiss(animated: false, completion: nil)
                    self.navigationController?.pushViewController(presentation_view_controller, animated: true)
                }
            }
        }
    }
    
    // Register button initialization
    let register_button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.setTitle("New to the app? Register here", for: .normal)
        
        // Must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 0, g: 163, b: 173), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to register button
        button.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)
        return button
    }()
    
    // Password text field initialization
    let password_text_field: UITextField = {
        let password_tf = UITextField()
        password_tf.placeholder = "Password"
        password_tf.translatesAutoresizingMaskIntoConstraints = false
        password_tf.isSecureTextEntry = true
        password_tf.autocapitalizationType = .none
        password_tf.autocorrectionType = .no
        return password_tf
    }()

    // Email text field initialization
    let email_text_field: UITextField = {
        let email_tf = UITextField()
        email_tf.placeholder = "Email"
        email_tf.translatesAutoresizingMaskIntoConstraints = false
        email_tf.autocapitalizationType = .none
        email_tf.autocorrectionType = .no
        return email_tf
    }()

    // Register button click functionality
    @objc func goToRegister() {
        // Ensure email and password are valid values
        let register_view_controller = RegisterController()
        self.navigationController?.pushViewController(register_view_controller, animated: true)
    }
  
    // Load main display for login screen
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create variables
        let login_view = LoginView()
        let profile_image_view = login_view.profile_image_view
        let inputs_view = login_view.inputs_view
        let email_separator_view = login_view.email_separator_view
        let password_separator_view = login_view.password_separator_view
        
        // Add subviews
        view.addSubview(profile_image_view)
        view.addSubview(inputs_view)
        view.addSubview(login_button)
        view.addSubview(register_button)
        
        // Change background color
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        
        // Call setup functions
        setUpProfileImageView(profile_image_view: profile_image_view, inputs_view: inputs_view)
        setUpInputsView(inputs_view: inputs_view, email_text_field: email_text_field, email_separator_view: email_separator_view, password_text_field: password_text_field, password_separator_view: password_separator_view)
        setUpLoginButton(login_button: login_button, inputs_view: inputs_view)
        setUpRegisterButton(register_button: register_button, inputs_view: inputs_view, login_button: login_button)
    }

    // Set up logo
    func setUpProfileImageView(profile_image_view: UIImageView, inputs_view: UIView) {
        profile_image_view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profile_image_view.bottomAnchor.constraint(equalTo: inputs_view.topAnchor, constant: -50).isActive = true
        profile_image_view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profile_image_view.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    // Set up input text fields
    func setUpInputsView(inputs_view: UIView, email_text_field: UITextField,
                        email_separator_view: UIView,
                        password_text_field: UITextField,
                        password_separator_view: UIView) {
        
        // Set constraints for inputs view
        inputs_view.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputs_view.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputs_view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputs_view.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        // Add subviews
        inputs_view.addSubview(email_text_field)
        inputs_view.addSubview(email_separator_view)
        inputs_view.addSubview(password_text_field)
        inputs_view.addSubview(password_separator_view)
        
        // Set constraints for email text field
        email_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        email_text_field.topAnchor.constraint(equalTo: inputs_view.topAnchor).isActive = true
        email_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        email_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/2).isActive = true
        
        // Set constraints for email separator view
        email_separator_view.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        email_separator_view.topAnchor.constraint(equalTo: email_text_field.bottomAnchor).isActive = true
        email_separator_view.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        email_separator_view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Set constraints for password text field
        password_text_field.leftAnchor.constraint(equalTo: inputs_view.leftAnchor, constant: 12).isActive = true
        password_text_field.topAnchor.constraint(equalTo: email_separator_view.bottomAnchor).isActive = true
        password_text_field.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        password_text_field.heightAnchor.constraint(equalTo: inputs_view.heightAnchor, multiplier: 1/2).isActive = true
        
        // Set constraints for password separator view
        password_separator_view.leftAnchor.constraint(equalTo: inputs_view.leftAnchor).isActive = true
        password_separator_view.topAnchor.constraint(equalTo: password_text_field.bottomAnchor).isActive = true
        password_separator_view.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        password_separator_view.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    // Set up login button
    func setUpLoginButton(login_button: UIButton, inputs_view: UIView) {
        // Set constraints for login button
        login_button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        login_button.topAnchor.constraint(equalTo: inputs_view.bottomAnchor, constant: 30).isActive = true
        login_button.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        login_button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // Set up register button
    func setUpRegisterButton(register_button: UIButton, inputs_view: UIView, login_button: UIButton) {
        // Set constraints for register button
        register_button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        register_button.topAnchor.constraint(equalTo: login_button.bottomAnchor, constant: 12).isActive = true
        register_button.widthAnchor.constraint(equalTo: inputs_view.widthAnchor).isActive = true
        register_button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
