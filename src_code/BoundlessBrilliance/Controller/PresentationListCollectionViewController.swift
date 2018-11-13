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
        
        _ = Alamofire.request(apiEndpoint, headers: auth_headers)
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
//    https://learnappmaking.com/pass-data-between-view-controllers-swift-how-to/
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //do stuff here
        //use presentationItems[indexPath.row] to get the presentation Item
        //pass the presentation item to a new view and segue
        let detailController = PresentationDetailController()
        detailController.presentation = presentationItems[indexPath.row]
        self.navigationController?.pushViewController(detailController, animated: true)
        
    }

    
    // This function passes data between view controllers
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        if segue.identifier == "ShowDetail" {
//            let detailVC = segue.destination as! ViewController
//
//            // Get the cell that generated this segue
//            if let selectedCel = sender as? PresentationListCollectionViewCell {
////                let indexPath = presentationItems.indexPath(for: selectedCel)!
//                let selectedItem = presentationItems[IndexPath.row]
//                detailVC.item = selectedItem[IndexPath.row]
//            }
//        } else if segue.identifier == "AddItem" {
//
//        }
//    }
    
    
    
    
    
//    @IBAction func unwindToList(sender: UIStoryboardSegue) {
//        let srcViewCon = sender.source as? ViewController
//        let item = srcViewCon?.item
//        if (srcViewCon != nil && item?.name != "") {
//            if let selectedIndexPath = tableView.indexPathForSelectedRow {
//                // Update an existing item
//                items[selectedIndexPath.row] = item!
//                tableView.reloadRows(at: [selectedIndexPath], with: .none)
//            } else {
//                // Add a new item
//                let newIndexPath = IndexPath(row: items.count, section: 0)
//                items.append(item!)
//                tableView.insertRows(at: [newIndexPath], with: .bottom)
//                //                saveItems()
//            }
//        }
//    }
}
