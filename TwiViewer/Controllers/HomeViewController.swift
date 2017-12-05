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
    
    var tweets: [Tweet] = []
    var CoreDataInstance = TweetsCData.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        let logoutButton = UIBarButtonItem(title: "<Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationController?.navigationItem.leftBarButtonItem = logoutButton
        
        
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
        return tweets.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "Cell"

        /*
        var cell: TweetTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID) as! TweetTableViewCell
        if (cell == nil) {
            cell = TweetTableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier:cellID)
        }
        
        //configure
        var innerView = InnerView(with: tweets[indexPath.row])
 
        
        cell.configureCell(with: innerView)
        */
        
        var cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        if (cell == nil) {
            cell = UITableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier:cellID)
        }
 
        return cell
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
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
                print("JSON: ",json)
                
                //parsing JSON, make an array [Tweet], self.tweets = [Tweet]
                
            } catch let JSONError as NSError {
                print("JSON error:",JSONError.localizedDescription)
            }
        }
    }
    
    
    @IBAction func logout() {
        Twitter.sharedInstance().sessionStore.logOutUserID((client?.userID)!)
        UserDefaults.standard.removeObject(forKey: "sessionStore")
        self.performSegue(withIdentifier: "WelcomeSegue", sender: self)

    }
}
