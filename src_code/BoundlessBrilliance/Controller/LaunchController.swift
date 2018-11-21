//
//  LaunchController.swift
//  BoundlessBrilliance
//
//  Created by Cassia Artanegara on 11/20/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Firebase

class LaunchController: UIViewController {
    
    var presentationItems: [PresentationListItemModel] = []
    var presenterChapter: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let launchView = LaunchView()
        let iconImageView = launchView.iconImageView
        
        view.addSubview(iconImageView)
        view.backgroundColor = UIColor(r: 0, g: 128, b: 128)
        setUpIconImageView(iconImageView: iconImageView)

        fetchPresentations()
        
        //Doesn't work (hopefully) because we need to pass presentationItems array to the next view.
        let newViewController = LoginScreenController()
        self.present(newViewController, animated: true)
    }
    
    func fetchPresentations () {
        
        
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://boundless-brilliance-22fa0.firebaseio.com/")
        
        let presentationRef = ref.child("presentations")
        var presentationDict: [String : Dictionary<String, Any>]!
        _ = presentationRef
            //.queryOrdered(byChild: "location")
            .observe(DataEventType.value, with: { (snapshot) in
                presentationDict = snapshot.value as? [String : Dictionary] ?? [:]
                
                
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
            let formatted_date : String = parseDateTime (datetime : date_string).0
            let formatted_time: String = parseDateTime(datetime : date_string).1
            
//            self.presentationItems.append(PresentationListItemModel(location: presentation["location"] as! String, names: parsedPresenterString, chapter: presenterChapter, time: formatted_time, date: formatted_date))
            
            self.presentationItems.append(PresentationListItemModel(location: presentation["location"] as! String, names: parsedPresenterString, chapter: "chapter", time: formatted_time, date: formatted_date))
            
        }
        
        print(presentationItems)
        
        
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
    func parseDateTime (datetime : String) -> (String, String) {
        
        // Create expected date format from string
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "yyyyMMdd'T'HHmmss"
        
        // Create ISO Date object from datetime string
        let iso_datetime : Date = date_formatter.date(from: datetime)!
        
        // Call functions to correctly parse date and times for start and end of presentation
        let date_string = parseDate(iso_date: iso_datetime, date_formatter: date_formatter)
        let time_string = parseTime(iso_date: iso_datetime, date_formatter: date_formatter)
        return (date_string, time_string)
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
    
    func setUpIconImageView (iconImageView: UIImageView) {
        iconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
    }
}
