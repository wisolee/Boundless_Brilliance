//
//  PresentationListCollectionViewController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/31/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class PresentationListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    // Added an array PresentationObjs
//    let presentationItems: [PresentationListItemModel] = [PresentationListItemModel(location: "Loc1", names: "Presenter1"), PresentationListItemModel(location: "Loc2", names: "Presenter2"), PresentationListItemModel(location: "Loc3", names: "Presenter3"), PresentationListItemModel(location: "Loc4", names: "Presenter4")]
    
    var presentationItems: [PresentationListItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createTabBarController()
        // Change the background color of the PresentationListView
        collectionView?.backgroundColor = UIColor.white

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        
        // Register cell classes
        self.collectionView!.register(PresentationListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        doAPIRequest()

        // Do any additional setup after loading the view.
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
        return PresentationListItemModel(location: "loc1", names: "presenter1", time: start_time, date: start_date)
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
        return presentationItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PresentationListCollectionViewCell
    
        // Configure the cell
        cell.configure(with: presentationItems[indexPath.row])
    
        return cell
    }
    
    // Custimizes layout of cells in collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding: CGFloat = 15
//        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: view.frame.width, height: 100)
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

    

}
