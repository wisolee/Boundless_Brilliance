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

            print(presentationDict)
            
            if (presentationDict != nil){
                self.loadDataIntoArray(presentationDict: presentationDict)
            }
        })
    }
    
    func loadDataIntoArray(presentationDict: [String : Dictionary<String, Any>]) {
        var presenterDict: Dictionary<String, String>!
        for values in presentationDict.values {
            // values["presenters"] as! Dictionary<String, String>)
            presenterDict = values["presenters"] as? Dictionary
            let parsedPresenterString = parsePresenterDictionary(presenterNames: Array(presenterDict.values))
            print(parsedPresenterString)
            
            self.presentationItems.append(PresentationListItemModel(location: values["location"] as! String, names: parsedPresenterString, chapter: "Occidental College", time: "9:00 AM", date: "11/17/18"))
            self.collectionView!.reloadData()
            // print(values["date"]!!)
            // let loc = values["location"]
            // let date = values["date"]
            
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
    
    // Retrieves data from 10to8 API and loads it into presentationItems array.
    func doAPIRequest(){
        let apiBaseEndpoint: String = "https://10to8.com/api/booking/v2/"
        
        let slot: String = "slot/?"
        let organisation: String = "organisation/?"
        let service: String = "service/?"
        let staff: String = "staff/?"
        let location: String = "location/?"
        
        let start_date: String = "start_date=2018-11-12"
        let end_date: String = "end_date=2018-12-12"
        
        let additional_info: String = "&location=https://10to8.com/api/booking/v2/location/242664/&staff=https://10to8.com/api/booking/v2/staff/72695/&service=https://10to8.com/api/booking/v2/service/509961/"
        
        
        // authorization header - DON'T CHANGE UNLESS AUTHORIZATION FAILS
        // test token: fdRiruCVyxvCHwud-kNoocYPv4dXiOpx6qhD0qXWeYpOL1itXrFiImOzmRs3
        // boundless brilliance token: gwu4bSt-fMRJr1io99N8ZckrAkcQvxfApy7VUuafe0W6NnHiGHAySDX1QGFf
        let auth_headers: HTTPHeaders = ["Authorization": "Token gwu4bSt-fMRJr1io99N8ZckrAkcQvxfApy7VUuafe0W6NnHiGHAySDX1QGFf"]
        
        // example of slot request
        let apiEndpoint: String = apiBaseEndpoint + slot + start_date + "&" + end_date + additional_info
        
        _ = Alamofire.request(apiEndpoint, headers: auth_headers)
            .responseJSON { response in
                
                // Parse JSON response into an array of presentation dictionaries
                if let responseArray = response.result.value as? [[String: String]] {
                    
                    // For every presentation in the response array: parse data, create new PresentationListItemModel, and append to presentationItems array
                    for presentation in responseArray {
                        let newPresentation = self.parseResponse(presentation: presentation)
                        self.presentationItems.append(newPresentation)
                    }
                    self.collectionView!.reloadData()
                }
        }
    }
    
    func parseResponse (presentation : [String: String]) -> PresentationListItemModel {
        
        // Parse response for datetime strings
        let start_datetime_string : String = presentation ["start_datetime"]!
        let end_datetime_string : String = presentation["end_datetime"]!
        
        // Create expected date format from string
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        // Create start and end dates from datetime strings
        let iso_start_date : Date = date_formatter.date(from: start_datetime_string)!
        let iso_end_date : Date = date_formatter.date(from: end_datetime_string)!
        
        // Call functions to correctly parse date and times for start and end of presentation
        let start_date = parseDate(iso_date: iso_start_date, date_formatter: date_formatter)
        let end_date = parseDate(iso_date: iso_end_date, date_formatter: date_formatter)
        let start_time = parseTime(iso_date: iso_start_date, date_formatter: date_formatter)
        let end_time = parseTime(iso_date: iso_end_date, date_formatter: date_formatter)
        
        // Return a new PresentationListItemModel
        return PresentationListItemModel(location: "loc1", names: "presenter1", chapter: "Occidental College", time: start_time, date: start_date)
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
