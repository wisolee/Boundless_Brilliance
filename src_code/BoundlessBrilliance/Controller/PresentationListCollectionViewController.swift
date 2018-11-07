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
    let presentationItems: [PresentationListItemModel] = [PresentationListItemModel(location: "Loc1", names: "Presenter1"), PresentationListItemModel(location: "Loc2", names: "Presenter2"), PresentationListItemModel(location: "Loc3", names: "Presenter3"), PresentationListItemModel(location: "Loc4", names: "Presenter4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createTabBarController()
        // Change the background color of the PresentationListView
        collectionView?.backgroundColor = UIColor.white

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        doAPIRequest()
        
        // Register cell classes
        self.collectionView!.register(PresentationListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

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
        
        let additional_info: String = "start_date=2018-11-12&end_date=2018-11-19&location=https://10to8.com/api/booking/v2/location/242664/&staff=https://10to8.com/api/booking/v2/staff/72695/&service=https://10to8.com/api/booking/v2/service/509961/"
        
        
        // authorization header - DON'T CHANGE UNLESS AUTHORIZATION FAILS
        // test token: fdRiruCVyxvCHwud-kNoocYPv4dXiOpx6qhD0qXWeYpOL1itXrFiImOzmRs3
        // boundless brilliance token: gwu4bSt-fMRJr1io99N8ZckrAkcQvxfApy7VUuafe0W6NnHiGHAySDX1QGFf
        let auth_headers: HTTPHeaders = ["Authorization": "Token gwu4bSt-fMRJr1io99N8ZckrAkcQvxfApy7VUuafe0W6NnHiGHAySDX1QGFf"]
        
        // example of slot request
        let apiEndpoint: String = apiBaseEndpoint + slot + additional_info
        
        let request = Alamofire.request(apiEndpoint, headers: auth_headers)
            .responseJSON { response in
                
                //creates an array with start_datetimes for the request
                if let responseArray = response.result.value as? [[String: String]] {
                    //If you want array of task id you can try like
                    print(responseArray)
                    
                    for presentation in responseArray {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'-'HH:mm"
                        
                        let timeFormatter = DateFormatter()
                        timeFormatter.dateFormat = "h:mm a"
                        
                        let start_datetime_string : String = presentation ["start_datetime"]!
                        let start_date : Date = dateFormatter.date(from: start_datetime_string)!
                        
                        let end_datetime_string : String = presentation["end_datetime"]!
                        let end_date : Date = dateFormatter.date(from:end_datetime_string)!
                        
                        print ("start: \(start_date), end: \(end_date)")
                    }
                    
                }
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

}
