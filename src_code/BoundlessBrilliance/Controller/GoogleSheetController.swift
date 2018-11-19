//
//  GoogleSheetController.swift
//  BoundlessBrilliance
//
//  Created by Cora Monokandilos on 11/18/18.
//  Copyright © 2018 BoundlessBrilliance. All rights reserved.
//


//doesn't work yet!!!!!!!!
import GoogleSignIn
import GoogleAPIClientForREST
import Foundation

import Alamofire

class GoogleSheetController : UIViewController {
    
    
    
    private let scopes = [kGTLRAuthScopeSheetsSpreadsheets]
    private let service = GTLRSheetsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.service.authorizer = GIDSignIn.sharedInstance().currentUser.authentication.fetcherAuthorizer()
        
        
        let sheetID = "1OAbhzY7RlfCEre-I5e-Kcgz16eHz2cGpO9HZKOiizCs"
        let range = "A3:B4"
        let requestParams = [
            "values": [
                ["hi1", "hi2"],
                ["hi3", "hi4"]
            ]
        ]
        let accessToken = GIDSignIn.sharedInstance().currentUser.authentication.accessToken!
        let header = ["Authorization":"Bearer \(accessToken)"]
        let requestURL = "https://sheets.googleapis.com/v4/spreadsheets/\(sheetID)/values/\(range)?valueInputOption=USER_ENTERED"
        let req = Alamofire.request(requestURL, method: .put, parameters: requestParams, encoding: JSONEncoding.default, headers: header)
        req.responseJSON { response in debugPrint(response) }
        
//        getData()
    }
    
//    func getData() {
//        let spreadsheetId = "1OAbhzY7RlfCEre-I5e-Kcgz16eHz2cGpO9HZKOiizCs" // Portfolio
//        let query = GTLRSheetsQuery_SpreadsheetsValuesGet.query(withSpreadsheetId: spreadsheetId, range:range)
//        service.executeQuery(query, delegate: self, didFinish: #selector(displayResultWithTicket(ticket:finishedWithObject:error:)))
//    }
}
