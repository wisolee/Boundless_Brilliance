//
//  ExtensionPresentationListViewController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 11/7/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

extension PresentationListCollectionViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    // MARK: - configure SearchController
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "Search Presentations"
        definesPresentationContext = true
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        
        self.navigationItem.titleView = searchController.searchBar
        
        // Setup Scope Bar
        self.searchController.searchBar.showsScopeBar = true
        // Set Scope Bar Titles
        if (presenterMemberType == "Presenter" || presenterMemberType == "Outreach Coordinator") {
            self.searchController.searchBar.scopeButtonTitles = [presenterChapter, presenterName]
        } else {
            self.searchController.searchBar.scopeButtonTitles = ["All", "Azusa Pacific University", "Los Angeles Trade Tech College", "Occidental College"]
        }
        
        
//        var ref: DatabaseReference!
//        ref = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
//        let userID = Auth.auth().currentUser!.uid
//        
//        ref.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
//            // Get user field(s)
//            let value = snapshot.value as? NSDictionary
//            let name = value?["name"] as? String ?? ""
//            let chapter = value?["chapter"] as? String ?? ""
//            let memberType = value?["memberType"] as? String ?? ""
//            
//            presenterName = name
//            presenterChapter = chapter
//            presenterMemberType = memberType
//        }) { (error) in
//            print(error.localizedDescription)
//        }
    }
    
    // MARK: Search Bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        self.dismiss(animated: true, completion: nil)
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
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText!, scope: scope)
    }
    
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    // MARK: Private Instance Methods
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        //return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
        return (searchController.isActive && !searchBarIsEmpty()) || searchBarScopeIsFiltering
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String) {
        filteredPresentationItems = presentationItems.filter({ (item) -> Bool in
            let presentationLocation: NSString = item.location as NSString
            let presentationNames: NSString = item.names as NSString
            let presentationTime: NSString = item.time as NSString
            let presentationDate: NSString = item.date as NSString
            
            var categoryMatch: Bool!
            if (presenterMemberType == "Presenter") {
                categoryMatch = ((item.names).range(of: scope, options: .caseInsensitive) != nil) || (item.chapter == scope)
            } else {
                categoryMatch = (scope == "All") || (item.chapter == scope)
            }
            
            if searchBarIsEmpty() {
                return categoryMatch
            } else {
                return categoryMatch
                    && ((presentationLocation.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                        || (presentationNames.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                        || (presentationTime.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
                        || (presentationDate.range(of: searchText, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound)
            }
        })
        collectionView.reloadData()
    }
    
}
