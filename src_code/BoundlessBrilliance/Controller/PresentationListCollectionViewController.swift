//
//  PresentationListCollectionViewController.swift
//  BoundlessBrilliance
//
//  Created by William Lee on 10/31/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class PresentationListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // Added an array PresentationObjs
    var presentationItems: [PresentationListItemModel]! = []
//        = [PresentationListItemModel(location: "Loc1", names: "Presenter1"), PresentationListItemModel(location: "Loc2", names: "Presenter2"), PresentationListItemModel(location: "Loc3", names: "Presenter3"), PresentationListItemModel(location: "Loc4", names: "Presenter4")]

//    override func didSelectItemAtIndexPath : (NSIndexPath *)indexPath{
//
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change the background color of the PresentationListView
        collectionView?.backgroundColor = UIColor.white

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(PresentationListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
//        self.collectionView.register(UINib.init(nibName: "PresentationListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        loadData()
    }
    
    func loadData(){
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
        
        let presentationRef = ref.child("presentations")
        var presentationDict: [String : AnyObject]!
        var presenterDict: [String : String]!
        _ = presentationRef.observe(DataEventType.value, with: { (snapshot) in
            presentationDict = snapshot.value as? [String : AnyObject] ?? [:]
            // add code here
            _ = presentationRef.child("presenters").observe(DataEventType.value, with: {(snapshot) in
                presenterDict = snapshot.value as? [String : String] ?? [:]
                print(presenterDict)
            })
            print(presentationDict)
            
            if (presentationDict != nil && presenterDict != nil){
                self.loadDataIntoArray(presentationDict: presentationDict, presenterDict: presenterDict)
            }
        })
    }
    
    func loadDataIntoArray(presentationDict: [String : AnyObject], presenterDict: [String: String]){
        
        for values in presentationDict.values {
            presentationItems.append(PresentationListItemModel(location: values["location"] as! String, presenters: values["presenters"] as! Dictionary<String, String>))
            //print(values["date"]!!)
            let loc = values["location"]
            // let date = values["date"]
            
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
