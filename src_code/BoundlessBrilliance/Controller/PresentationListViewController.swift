//
//  PresentationListViewController.swift
//  BoundlessBrilliance
//
//  Created by Vinod Krishnamurthy on 10/28/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
//import requests

public typealias HTTPHeaders = [String: String]

class PresentationListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // example of slot request
        let apiEndpoint: String = "https://10to8.com/api/booking/v2/slot/?start_date=2018-11-12&end_date=2018-11-19&location=https://10to8.com/api/booking/v2/location/242664/&staff=https://10to8.com/api/booking/v2/staff/72695/&service=https://10to8.com/api/booking/v2/service/509961/"
        
        // authorization header - DON'T CHANGE UNLESS AUTHORIZATION FAILS
        let auth_headers: HTTPHeaders = ["Authorization": "Token gwu4bSt-fMRJr1io99N8ZckrAkcQvxfApy7VUuafe0W6NnHiGHAySDX1QGFf"]
        
        let request = Alamofire.request(apiEndpoint, headers: auth_headers)
            .responseJSON { response in
                //print(response.result.value!)
                debugPrint(response)
        }
        debugPrint(request)
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
