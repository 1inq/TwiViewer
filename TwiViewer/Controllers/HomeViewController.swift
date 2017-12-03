//
//  HomeViewController.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 01.12.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit
import TwitterKit

class HomeViewController: UITableViewController {
    
    var client : TWTRAPIClient?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            self.client = TWTRAPIClient(userID: userID)
        }
        
        homeTimelineRequest()
        
        //ConnectionClient.sharedManager.homeTimeline()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: -Table View Data Source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "Cell"

        var cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID)
        if (cell == nil) {
            cell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier:cellID)
        }
        cell!.textLabel!.text = "\(indexPath.row)"
    
        return cell!
    }
    
    func homeTimelineRequest() {
        let homeTimeLineEndPoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": "2"]
        var clientError: NSError?
        let request = self.client?.urlRequest(withMethod: "GET", url: homeTimeLineEndPoint, parameters: params, error: &clientError)
            
        self.client?.sendTwitterRequest(request!) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error", connectionError)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("JSON: ",json)
                
                /*
                for status in json {
                    print("Text: ", status["text"])
                }
                */
            } catch let JSONError as NSError {
                print("JSON error:",JSONError.localizedDescription)
            }
        }
    }
    
    
    @IBAction func logout() {
        ConnectionClient.sharedManager.deauthorize()
        self.dismiss(animated: true){}

    }
}
