//
//  PresentationListCollectionViewController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/31/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase
import Alamofire

private let cellReuseIdentifier = "Cell"
private let searchBarHeight = 50
private let cellHeight = 100

class PresentationListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // We keep track of the pending work item as a property
    private var pending_request_work_item: DispatchWorkItem?
    var is_searching: Bool = false
    var search_controller: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register cell classes
        self.collectionView!.register(PresentationListCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        // Configure presentationListCollectionView
        configureNavigationBar()
        configureCollectionView()
        configureSearchController()
        scrollToToday()
        
        self.collectionView!.reloadData()
    }
    
    // Scrolls to presentation whose date is or is closest to the current date
    func scrollToToday() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let currentDate = dateFormatter.date(from: dateFormatter.string(from: date))
        var index: Int = 0
        for presentation in presentation_items {
            let presentationDate = dateFormatter.date(from: presentation.date)
            if (presentationDate! >= currentDate!) {
                self.collectionView.scrollToItem(at:IndexPath(item: index, section: 0), at: .top, animated: false)
                return
            }
            index += 1
        }
    }

    // MARK: UICollectionViewDataSource

    // Returns the number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Returns the number of presentations
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        is_searching = isFiltering()
        if is_searching {
            return filtered_presentation_items.count
        } else {
            return presentation_items.count
        }
    }

    // Configures cell based off custom cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! PresentationListCollectionViewCell
        
        // Configure the cell
        is_searching = isFiltering()
        if is_searching {
            cell.configure(with: filtered_presentation_items[indexPath.row])
        } else {
            cell.configure(with: presentation_items[indexPath.row])
        }
        return cell
    }
    
    // Customizes layout of cells in collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(cellHeight))
    }

    // MARK: UICollectionViewDelegate
    
    // Passes the selected presentation item to a detail view and segues
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = PresentationDetailController()

        is_searching = isFiltering()
        if is_searching {
            detailController.presentation = filtered_presentation_items[indexPath.row]
        } else {
            detailController.presentation = presentation_items[indexPath.row]
        }
        self.navigationController?.pushViewController(detailController, animated: true)
    }

    // MARK: - Private setup methods for UIsubviews
    
    // Configures navigation bar with desired settings
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = UIColor(r: 0, g: 163, b: 173)
        navigationController?.navigationBar.barTintColor = UIColor(r: 220, g: 220, b: 220)
    }
    
    // Configures collection view with desired settings
    func configureCollectionView() {
        self.collectionView?.backgroundColor = UIColor.white
        view.addSubview(log_out_button)
        setupLogOutButton()
    }
    
    // Subview - log_out_button
    let log_out_button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 163, b: 173)
        button.setTitle("Logout", for: .normal)
        
        // Must set up this property otherwise, the specified anchors will not work
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        // Additional styling
        button.layer.cornerRadius = 14
        button.layer.shadowColor = UIColor(r: 0, g: 0, b: 0).cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 5)
        button.layer.shadowRadius = 8
        button.layer.shadowOpacity = 0.5
        button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 14, height: 14)).cgPath
        
        // Add action to log_out_button
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        return button
    }()
    
    // Clears currently loaded presentations and navigates back to login page
    @objc func logOut() {
        // Go back to login page
        presentation_items.removeAll()
        self.navigationController?.popViewController(animated: true)
    }
    
    // Setup contraints for log_out_button
    func setupLogOutButton() {
        log_out_button.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        log_out_button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 12).isActive = true
        log_out_button.widthAnchor.constraint(equalToConstant: 100).isActive = true
        log_out_button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
