//
//  ViewController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/14/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Allowing data to be saved
//        var ref: DatabaseReference!
//        
//        ref = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
//        ref.updateChildValues(["someValue": 123])
        
        // logout button on initial screen
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleLogout))
    }
    
    // launch LoginController whenever "Logout" button is pressed
    @objc func handleLogout() {
        let loginController = RegisterController()
        present(loginController, animated: true, completion: nil)
    }


}
