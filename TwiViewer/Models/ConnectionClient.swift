//
//  ConnectionClient.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 29.11.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit
import WebKit
import TwitterKit
import SwiftyJSON

class ConnectionClient : TWTRAPIClient {
    
    static let instance = ConnectionClient()
    static let client = TWTRAPIClient.withCurrentUser()
    
    func homeTimelineRequest() {
        var tweets : [TweetModel] = []
        TweetsCData.instance.clearCD()
        let homeTimeLineEndPoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": "5"]
        var clientError: NSError?
        let request = ConnectionClient.client.urlRequest(withMethod: "GET", url: homeTimeLineEndPoint, parameters: params, error: &clientError)
        
        ConnectionClient.client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error", connectionError)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [NSDictionary]
                print("JSON: ",json)
                let json2 = JSON(json)
                
                for (index,subJson):(String, JSON) in json2 {
                    
                    let ts = TweetModel(withJson: subJson)
                    tweets.append(ts)
                }
                TweetsCData.instance.addObjectsToCD(tweets:tweets)
                TweetsCData.instance.printCD()
                //self.tableView.reloadData()
                print("wait....")
            } catch let JSONError as NSError {
                print("JSON error:",JSONError.localizedDescription)
            }
        }
    }
}
