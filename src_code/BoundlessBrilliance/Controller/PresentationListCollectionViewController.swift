//
//  PresentationListCollectionViewController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/31/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

private let cellReuseIdentifier = "Cell"

private let searchBarHeight = 50
private let cellHeight = 100

class PresentationListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var presentationItems = [PresentationListItemModel]()
    var filteredPresentationItems = [PresentationListItemModel]()
    
    var isSearching: Bool = false
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(PresentationListCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
        // Do any additional setup after loading the view.
        configureNavigationBar()
        configureCollectionView()
        configureSearchController()
        loadListOfPresentations()
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
    
    // Custimizes layout of cells in collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        let padding: CGFloat = 15
        //        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: view.frame.width, height: CGFloat(cellHeight))
    }
    
    // Repositions first cell with respect to searchBar (no more overlapping)
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: CGFloat(searchBarHeight))
//    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

    // MARK: - Private setup methods for UIsubviews
    
    func configureNavigationBar() {
        navigationItem.title = "Presentations"
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = UIColor(r: 0, g: 128, b: 128)
    }
    
    func configureCollectionView() {
        self.collectionView?.backgroundColor = UIColor.white
    }
    
    func setupPresentationSearchBar() {
        /* need x, y, width, height contraints */
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        searchController.searchBar.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
        searchController.searchBar.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
        searchController.searchBar.heightAnchor.constraint(equalToConstant: CGFloat(searchBarHeight)).isActive = true
    }
    
    // MARK: - Private methods for presentationData
    func loadListOfPresentations() {
        presentationItems.append(PresentationListItemModel(location: "Los Angeles", names: "John", chapter: "Azusa Pacific University"))
        presentationItems.append(PresentationListItemModel(location: "San Francisco", names: "Jermaine", chapter: "Azusa Pacific University"))
        presentationItems.append(PresentationListItemModel(location: "Santa Cruz", names: "Peter", chapter: "Los Angeles Trade Tech College"))
        presentationItems.append(PresentationListItemModel(location: "San Diego", names: "Alexios", chapter: "Los Angeles Trade Tech College"))
        presentationItems.append(PresentationListItemModel(location: "New York", names: "Billy", chapter: "Occidental College"))
        presentationItems.append(PresentationListItemModel(location: "Athens", names: "Alexios", chapter: "Occidental College"))
        presentationItems.append(PresentationListItemModel(location: "Paris", names: "Buderrrriiiii", chapter: "Occidental College"))
        presentationItems.sort { $0.location < $1.location }
    }
    
}
