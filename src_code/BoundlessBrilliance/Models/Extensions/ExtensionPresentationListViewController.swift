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
    
    // MARK: Configure SearchController
    
    // Configures search_controller with desired settings
    func configureSearchController() {
        // Create search_controller only for presentationListView
        self.search_controller = UISearchController(searchResultsController: nil)
        
        // Set the delegates
        self.search_controller.searchResultsUpdater = self
        self.search_controller.delegate = self
        self.search_controller.searchBar.delegate = self
        
        // search_controller visual tweaks
        self.search_controller.hidesNavigationBarDuringPresentation = false
        self.search_controller.dimsBackgroundDuringPresentation = true
        self.search_controller.obscuresBackgroundDuringPresentation = false
        
        self.search_controller.searchBar.placeholder = "Search Presentations"
        definesPresentationContext = true
        self.search_controller.searchBar.sizeToFit()
        
        self.search_controller.searchBar.becomeFirstResponder()
        
        // Place searchBar at titleView position of navigationBar
        self.navigationItem.titleView = search_controller.searchBar
        
        // Setup Scope Bar
        self.search_controller.searchBar.showsScopeBar = true
        self.search_controller.searchBar.barTintColor = UIColor(r: 220, g: 220, b: 220)
        
        // Set Scope Bar Titles
        if (presenter_member_type == "Presenter" || presenter_member_type == "Outreach Coordinator") {
            self.search_controller.searchBar.scopeButtonTitles = [presenter_chapter, presenter_name]
        } else {
            self.search_controller.searchBar.scopeButtonTitles = ["All", "Azusa Pacific University", "Los Angeles Trade Tech College", "Occidental College"]
        }
    }
    
    // MARK: Search Bar
    
    // Sets is_searching to false and clears current query
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        is_searching = false
        self.dismiss(animated: true, completion: nil)
    }
    
    // Sets is_searching to true and reloads page as query is being typed
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        is_searching = true
        collectionView.reloadData()
    }
    
    // Sets is_searching to false and reloads page when search bar is clicked
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        is_searching = false
        collectionView.reloadData()
    }
    
    // Tells the delgate wether or not the bookmark button was tapped
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !is_searching {
            is_searching = true
            collectionView.reloadData()
        }
        search_controller.searchBar.resignFirstResponder()
    }
    
    // MARK: UISearchResultsUpdating Delegate
    
    // Updates search results when search queries are made and/or presentation categories are chosen
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchText!, scope: scope)
    }
    
    // MARK: UISearchBar Delegate
    
    // Allows search bar to utilize custom filtering function
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    // MARK: Private Instance Methods
    
    // Checks if presentations are being filtered by query or presentation category selection
    func isFiltering() -> Bool {
        let searchBarScopeIsFiltering = search_controller.searchBar.selectedScopeButtonIndex != 0
        return (search_controller.isActive && !searchBarIsEmpty()) || searchBarScopeIsFiltering
    }
    
    // Checks if search bar contains any text or not
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return search_controller.searchBar.text?.isEmpty ?? true
    }
    
    // Filters presentations by typed in search text and/or presentation category
    func filterContentForSearchText(_ searchText: String, scope: String) {
        filtered_presentation_items = presentation_items.filter({ (item) -> Bool in
            let presentationLocation: NSString = item.location as NSString
            let presentationNames: NSString = item.names as NSString
            let presentationTime: NSString = item.time as NSString
            let presentationDate: NSString = item.date as NSString
            
            var categoryMatch: Bool!
            if (presenter_member_type == "Presenter") {
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
