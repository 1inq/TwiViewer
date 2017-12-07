//
//  HomeViewController.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 01.12.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON

class HomeViewController: UITableViewController {
    
    var tweets: [TweetStruct] = []
    var client : TWTRAPIClient?
    
    let CoreDataInstance = TweetsCData.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshdata), for: .valueChanged)
        tableView.refreshControl = refreshControl
        CoreDataInstance
        
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            self.client = TWTRAPIClient(userID: userID)
        }
        
        //CoreDataInstance.clearCD()
        
        homeTimelineRequest()
        //CoreDataInstance.addObjectsToCD(tweets: tweets)
        //CoreDataInstance.printCD()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let logoutButton = UIBarButtonItem(title: "<Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationController?.navigationItem.rightBarButtonItem = logoutButton
        
        self.navigationController?.title = "Home Timeline"
        
        //homeTimelineRequest()
        //CoreDataInstance.printCD()
        //tableView.reloadData()
    }
    
    // MARK: - Table View Data Source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    */
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataInstance.allObjects().count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = "TweetCell"

        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! TweetTableViewCell
        if (cell == nil) {
            cell = TweetTableViewCell(style:UITableViewCellStyle.subtitle, reuseIdentifier:cellID)
        }
        
        cell.nameLabel?.text = self.CoreDataInstance.allObjects()[indexPath.row].text
        cell.screenNameLabel?.text = "@" + self.CoreDataInstance.allObjects()[indexPath.row].screenName!
        cell.nameLabel?.text = self.CoreDataInstance.allObjects()[indexPath.row].name
        
        /*
        let imageData = self.CoreDataInstance.allObjects()[indexPath.row].image
         cell.personalImageView?.image = UIImage(data: imageData!)
        */
        
        let imageURL = URL(fileURLWithPath: self.CoreDataInstance.allObjects()[indexPath.row].image!)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: data!)
            }
        }
        
        
        
        cell.tweetTextLabel?.text = self.CoreDataInstance.allObjects()[indexPath.row].text
        cell.tweetTextLabel?.numberOfLines = 0
        cell.tweetTextLabel?.sizeToFit()
        cell.tweetTextLabel?.layer.cornerRadius = 5
        
        
        
        let df = DateFormatter()
        df.dateFormat = "hh:mm dd/MM"
        let dateString = df.string(from: self.CoreDataInstance.allObjects()[indexPath.row].created_at as! Date)
        
        cell.imageView?.image
 
        cell.created_at?.text = dateString
        
        cell.textLabel?.text = ""
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - methods
    
    func homeTimelineRequest() {
        self.tweets = []
        CoreDataInstance.clearCD()
        let homeTimeLineEndPoint = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count": "100"]
        var clientError: NSError?
        let request = self.client?.urlRequest(withMethod: "GET", url: homeTimeLineEndPoint, parameters: params, error: &clientError)
        
        self.client?.sendTwitterRequest(request!) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error", connectionError)
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [NSDictionary]
                print("JSON: ",json)
                let json2 = JSON(json)
                
                for (index,subJson):(String, JSON) in json2 {
                    
                    if let username = subJson["user"]["name"].string {
                        if let screenName = subJson["user"]["screen_name"].string {
                            if let image = subJson["user"]["profile_image_url_https"].string {
                                if let text = subJson["text"].string {
                                    if let id_str = subJson["id_str"].string {
                                        if let created_at = subJson["created_at"].string {
                                            let dateFormatter = DateFormatter()
                                            //Tue Aug 28 21:16:23 +0000 2012
                                            dateFormatter.dateFormat = ("EEE MMM dd hh:mm:ss +zzzz yyyy")
                                            dateFormatter.locale = Locale(identifier: "en_GB")
                                            dateFormatter.timeZone = TimeZone(secondsFromGMT: 6*60*60)
                                            let dateObj = dateFormatter.date(from: created_at)
                                            var ts = TweetStruct(id_str: id_str, name: username, screenName: screenName, image: image, text: text, created_at: dateObj as! NSDate)
                                            
                                            self.tweets.append(ts)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                self.CoreDataInstance.addObjectsToCD(tweets:self.tweets)
                self.CoreDataInstance.printCD()
                self.tableView.reloadData()
                print("wait....")
            } catch let JSONError as NSError {
                print("JSON error:",JSONError.localizedDescription)
            }
        }
    }
    
    @objc func refreshdata() {
        //homeTimelineRequest()
    }
    
    @objc func logout() {
        Twitter.sharedInstance().sessionStore.logOutUserID((client?.userID)!)
        UserDefaults.standard.removeObject(forKey: "sessionStore")
        //self.tweets = []
        self.navigationController?.popToRootViewController(animated: true)

    }
}
