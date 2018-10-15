//
//  ViewController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/14/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // logout button on initial screen
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(handleLogout))
    }
    
    // launch LoginController whenever "Logout" button is pressed
    @objc func handleLogout() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }


}
