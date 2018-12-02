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
    private var pendingRequestWorkItem: DispatchWorkItem?
    var isSearching: Bool = false
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(PresentationListCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)

        configureNavigationBar()
        configureCollectionView()
        configureSearchController()
        scrollToToday()
        self.collectionView!.reloadData()
    }
    
    func scrollToToday(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = Date()
        let currentDate = dateFormatter.date(from: dateFormatter.string(from: date))
        var index: Int = 0
        for presentation in presentationItems {
            let presentationDate = dateFormatter.date(from: presentation.date)
            if (presentationDate! >= currentDate!){
                self.collectionView.scrollToItem(at:IndexPath(item: index, section: 0), at: .top, animated: false)
                return
            }
            index += 1
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        isSearching = isFiltering()
        if isSearching {
            return filteredPresentationItems.count
        } else {
            return presentationItems.count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! PresentationListCollectionViewCell
        
        // Configure the cell
        isSearching = isFiltering()
        if isSearching {
            cell.configure(with: filteredPresentationItems[indexPath.row])
        } else {
            cell.configure(with: presentationItems[indexPath.row])
        }
        
        return cell
    }
    
    // Customizes layout of cells in collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: CGFloat(cellHeight))
    }

    // MARK: UICollectionViewDelegate
//    https://learnappmaking.com/pass-data-between-view-controllers-swift-how-to/
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //do stuff here
        //use presentationItems[indexPath.row] to get the presentation Item
        //pass the presentation item to a new view and segue
        let detailController = PresentationDetailController()
        detailController.presentation = presentationItems[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }

    // MARK: - Private setup methods for UIsubviews
    func configureNavigationBar() {
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = UIColor(r: 0, g: 128, b: 128)
        //navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut))
    }
    
    func configureCollectionView() {
        self.collectionView?.backgroundColor = UIColor.white
        view.addSubview(logOutButton)
        setupLogOutButton()
    }
    
    // subview - returnButton
    let logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        button.setTitle("Logout", for: .normal)
        // must set up this property otherwise, the specified anchors will not work
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
        // Add action to registerButton
        button.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        
        return button
    }()
    
    @objc func logOut(){
        //go back to login
        presentationItems.removeAll()
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupLogOutButton(){
        logOutButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        logOutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 12).isActive = true
        logOutButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        logOutButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
}
