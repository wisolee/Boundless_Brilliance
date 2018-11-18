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
    

    var presentationItems: [PresentationListItemModel] = []
    var filteredPresentationItems = [PresentationListItemModel]()
    
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
        //doAPIRequest()
        
        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData(){
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
        
        let presentationRef = ref.child("presentations")
        var presentationDict: [String : Dictionary<String, Any>]!
        _ = presentationRef.observe(DataEventType.value, with: { (snapshot) in
            presentationDict = snapshot.value as? [String : Dictionary] ?? [:]
            
            print (presentationDict)
            
            if (presentationDict != nil){
                self.loadDataIntoArray(presentationDict: presentationDict)
            }
        })
    }
    
    func loadDataIntoArray(presentationDict: [String : Dictionary<String, Any>]) {
        var presenterDict: Dictionary<String, String>!
        for presentation in presentationDict.values {
            // values["presenters"] as! Dictionary<String, String>)
            presenterDict = presentation["presenters"] as? Dictionary
            let parsedPresenterString = parsePresenterDictionary(presenterNames: Array(presenterDict.values))
            print(parsedPresenterString)
            
            
            
            let date_string : String = presentation["date"] as! String
            let formatted_date : String = parseDateTime (datetime : date_string)
         
            self.presentationItems.append(PresentationListItemModel(location: presentation["location"] as! String, names: parsedPresenterString, chapter: "Occidental College", time: "9:00 AM", date: formatted_date))
            self.collectionView!.reloadData()

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
    func parseDateTime (datetime : String) -> String {
        
        // Create expected date format from string
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "yyyyMMdd'T'HHmmss"
        
        // Create start and end dates from datetime strings
        let iso_datetime : Date = date_formatter.date(from: datetime)!
        
        // Call functions to correctly parse date and times for start and end of presentation
        let date_string = parseDate(iso_date: iso_datetime, date_formatter: date_formatter)
        
        return date_string
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
        //        let padding: CGFloat = 15
        //        let collectionViewSize = collectionView.frame.size.width - padding
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
//        presentationItems.append(PresentationListItemModel(location: "Los Angeles", names: "John", chapter: "Azusa Pacific University", time: "12:00pm", date: "10/10/18"))
//        presentationItems.sort { $0.location < $1.location }
    }
    
}
