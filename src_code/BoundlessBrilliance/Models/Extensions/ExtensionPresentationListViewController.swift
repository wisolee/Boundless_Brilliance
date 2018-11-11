//
//  ExtensionPresentationListViewController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 11/7/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit

extension PresentationListCollectionViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search presentations"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar
//        self.navigationItem.searchController = searchController
//        collectionView.addSubview(searchController.searchBar)
//        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
//        searchController.searchBar.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
//        searchController.searchBar.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
//        searchController.searchBar.widthAnchor.constraint(equalTo: collectionView.widthAnchor).isActive = true
//        searchController.searchBar.heightAnchor.constraint(equalToConstant: CGFloat(50)).isActive = true
    }
    
    // MARK: Search Bar
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchPredicate = searchController.searchBar.text
        
        filteredPresentationItems = presentationItems.filter({ (item) -> Bool in
            let presentationText: NSString = item.location as NSString
            
            return (presentationText.range(of: searchPredicate!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
        })
        
        collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
        collectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        collectionView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !isSearching {
            isSearching = true
            collectionView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    
}
