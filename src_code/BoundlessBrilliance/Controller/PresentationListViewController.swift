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
        
        let apiEndpoint: String = "https://10to8.com/api/booking/v2/service/?format=json"
        
        let auth_headers: HTTPHeaders = ["Authorization": "Token <fdRiruCVyxvCHwud-kNoocYPv4dXiOpx6qhD0qXWeYpOL1itXrFiImOzmRs3>"]
        
        let headers: HTTPHeaders = ["Authorization": "fdRiruCVyxvCHwud-kNoocYPv4dXiOpx6qhD0qXWeYpOL1itXrFiImOzmRs3"]
        
        let request = Alamofire.request(apiEndpoint, headers: headers)
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
