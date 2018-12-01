//
//  LoginScreenController.swift
//  BoundlessBrilliance
//
//  Created by Cora Monokandilos on 10/16/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

var presenterChapter: String!
var presenterName: String!
var presenterMemberType: String!

let firebaseGroup = DispatchGroup()

var presentationItems: [PresentationListItemModel] = []
var filteredPresentationItems = [PresentationListItemModel]()

class LoginScreenController: UIViewController {
    //     subview - LoginButton
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        button.setTitle("Login", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to LoginButton
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)

        
        return button
    }()
    

    //action for loginButton -- authenticates user
    @objc func handleLogin() {

        guard let email = emailTextField.text, let password = passwordTextField.text
            else {
                print("Form input is not valid")
                return
        }
        let chapterScheduleVC = PresentationListCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.dismiss(animated: false, completion: nil)
                self.view.makeToast("User not found or incorrect password.")
                print("User or password not found")
                print(error as Any)
                return
            } else {
                print("Successfully authenticated user")
                print(user as Any)
                self.startLoadingAlert()
                self.loadData()
                
                firebaseGroup.notify(queue: .main) {
                    presentationItems.sort { $0.date < $1.date }
                    self.dismiss(animated: false, completion: nil)
                    self.navigationController?.pushViewController(chapterScheduleVC, animated: true)
                }
            }
        }

    }
    
    func startLoadingAlert() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        self.present(alert, animated: false, completion: nil)
    }
    
    func loadData(){
        let ref: DatabaseReference! = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
        let userID = Auth.auth().currentUser!.uid
        let presentationRef = ref.child("presentations")
        var presentationDict: [String : Dictionary<String, Any>]!
        
        firebaseGroup.enter()
        _ = presentationRef
            .observe(DataEventType.value, with: { (snapshot) in
                presentationDict = snapshot.value as? [String : Dictionary] ?? [:]
                if (presentationDict != nil){
                    self.loadDataIntoArray(presentationDict: presentationDict, ref: ref)
                }
            })
        
        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user field(s)
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let chapter = value?["chapter"] as? String ?? ""
            let memberType = value?["memberType"] as? String ?? ""
            
            presenterName = name
            presenterChapter = chapter
            presenterMemberType = memberType
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func loadDataIntoArray(presentationDict: [String : Dictionary<String, Any>], ref: DatabaseReference) {
        var presenterDict: Dictionary<String, String>!
        var presentationNum = presentationDict.count
        for presentation in presentationDict.values {
            presenterDict = presentation["Presenters"] as? Dictionary
            let parsedPresenterString = parsePresenterDictionary(presenterNames: Array(presenterDict.values))
            
            print(parsedPresenterString)
            
            let date_string : String = presentation["Date"] as! String
            let formatted_date : String = parseDateTime (datetime : date_string).0
            let formatted_time: String = parseDateTime(datetime : date_string).1
            
            print(formatted_date)
            print(formatted_time)
            
            var presentationChapter: String!
            retrieveChapter(presenterDict: presenterDict, ref: ref, completion: { message in
                // callback from completion handler
                presentationChapter = message
                /* create presentationItem with necessary fields */
                if (presenterMemberType == "Presenter" || presenterMemberType == "Outreach Coordinator") {
                    // only load presentations from the presenter's chapter
                    if  presenterChapter == presentationChapter {
                        print(presentationChapter)
                        presentationItems.append(PresentationListItemModel(location: presentation["location"] as! String, names: parsedPresenterString, chapter: presentationChapter, time: formatted_time, date: formatted_date))
                    }
                } else {
                    // load presentations from all chapters
                    presentationItems.append(PresentationListItemModel(location: presentation["location"] as! String, names: parsedPresenterString, chapter: presentationChapter, time: formatted_time, date: formatted_date))
                }
                presentationNum -= 1
                print("done retrieving chapter")
                print(presentationNum)
                if(presentationNum == 0){
                    firebaseGroup.leave()
                }
            })
        }
    }
    
    func retrieveChapter(presenterDict: Dictionary<String, String>, ref: DatabaseReference, completion: @escaping (_ message: String) -> Void) {
        var presentationChapter: String!
        // Obtain userID from first presenter
        let firstUserID = Array(presenterDict.keys)[0]
        ref.child("users").child(firstUserID).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user chapter field
            guard
                let value = snapshot.value as? NSDictionary,
                let chapter = value["chapter"]
                else {
                    completion("")
                    return
            }
            presentationChapter = chapter as? String
            completion(presentationChapter)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func parsePresenterDictionary(presenterNames: Array<String>) -> String {
        var namesString: String = ""
        if (presenterNames.count == 1) {
            return presenterNames[0]
        } else if (presenterNames.count > 1) {
            var index = 0
            for name in presenterNames {
                namesString.append(contentsOf: name)
                if (index != presenterNames.count - 1){
                    namesString.append(contentsOf: ", ")
                }
                index += 1
            }
        } else {
            namesString = "No presenters listed."
        }
        return namesString
    }
    
    // This currenty cannot be abstracted to work for retrieving date AND time, only date
    func parseDateTime (datetime : String) -> (String, String) {
        
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
    
    func parseDate (iso_date: Date, date_formatter: DateFormatter) -> String {
        // Create desired date format
        date_formatter.dateFormat = "yyyy-MM-dd"
        let date_string = date_formatter.string(from: iso_date)
        return date_string
    }
    
    func parseTime (iso_date: Date, date_formatter: DateFormatter) -> String {
        // Create desired time format
        date_formatter.dateFormat = "EEE hh:mm a"
        let time_string = date_formatter.string(from: iso_date)
        return time_string
    }
    
    // subview - registerButton
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        button.setTitle("New to the app? Register here", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor(r: 0, g: 128, b: 128), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 5
        
        // Add action to registerButton
        button.addTarget(self, action: #selector(goToRegister), for: .touchUpInside)

        
        return button
    }()
    
    // subview - nameTextField
    let passwordTextField: UITextField = {
        let password_tf = UITextField()
        password_tf.placeholder = "Password"
        password_tf.translatesAutoresizingMaskIntoConstraints = false
        password_tf.isSecureTextEntry = true
        password_tf.autocapitalizationType = .none
        password_tf.autocorrectionType = .no
        return password_tf
    }()

    // subview - nameTextField
    let emailTextField: UITextField = {
        let email_tf = UITextField()
        email_tf.placeholder = "Email"
        email_tf.translatesAutoresizingMaskIntoConstraints = false
        email_tf.autocapitalizationType = .none
        email_tf.autocorrectionType = .no
        return email_tf
    }()

    
    // registerButton action starts the register activity
    @objc func goToRegister() {
        // Ensure email and password are valid values
        let newViewController = RegisterController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
  
    // Main Display---------------------------------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        //create variables
        let loginView = LoginView()
        let profileImageView = loginView.profileImageView
        let inputsView = loginView.inputsView
        let emailSeparatorView = loginView.emailSeparatorView
        let passwordSeparatorView = loginView.passwordSeparatorView
        
        /* Add subviews */
        view.addSubview(profileImageView)
        view.addSubview(inputsView)
        view.addSubview(loginButton)
        view.addSubview(registerButton)
//        view.addSubview(profileImageView)
        
        view.backgroundColor = UIColor(r: 255, g: 255, b: 255)
        setUpProfileImageView(profileImageView: profileImageView, inputsView: inputsView)
        setUpInputsView(inputsView: inputsView, emailTextField: emailTextField, emailSeparatorView: emailSeparatorView, passwordTextField: passwordTextField, passwordSeparatorView: passwordSeparatorView)
        setUpLoginButton(loginButton: loginButton, inputsView: inputsView)
        setUpRegisterButton(registerButton: registerButton, inputsView: inputsView, loginButton: loginButton)
        
        
    }
    
    func setUpProfileImageView(profileImageView: UIImageView, inputsView: UIView) {
        /* need x, y, width, height contraints */
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsView.topAnchor, constant: -50).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
    
    func setUpInputsView(inputsView: UIView, emailTextField: UITextField,
                        emailSeparatorView: UIView,
                        passwordTextField: UITextField,
                        passwordSeparatorView: UIView) {
        /* need x, y, width, height contraints */
        inputsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: -24).isActive = true
        inputsView.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        /* adding placeholder subviews */
        inputsView.addSubview(emailTextField)
        inputsView.addSubview(emailSeparatorView)
        inputsView.addSubview(passwordTextField)
        inputsView.addSubview(passwordSeparatorView)
        
        // nameTextField: need x, y, width, height contraints
        emailTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: inputsView.topAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2).isActive = true // 1/2 of entire height
        
        // nameSeparatorView: need x, y, width, height contraints
        emailSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        emailSeparatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        emailSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // emailTextField: need x, y, width, height contraints
        passwordTextField.leftAnchor.constraint(equalTo: inputsView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailSeparatorView.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsView.heightAnchor, multiplier: 1/2).isActive = true // 1/2 of entire height
        
        // emailSeparatorView: need x, y, width, height contraints
        passwordSeparatorView.leftAnchor.constraint(equalTo: inputsView.leftAnchor).isActive = true
        passwordSeparatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeparatorView.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        passwordSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    func setUpLoginButton(loginButton: UIButton, inputsView: UIView) {
        /* need x, y, width, height contraints */
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: inputsView.bottomAnchor, constant: 30).isActive = true
        loginButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setUpRegisterButton(registerButton: UIButton, inputsView: UIView, loginButton: UIButton) {
        /* need x, y, width, height contraints */
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: inputsView.widthAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
