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

//MARK: - HomeViewController

class HomeViewController: UITableViewController {
    
    var tweets: [TweetModel] = []
    var client : TWTRAPIClient?
    
    
    let CoreDataInstance = TweetsCData.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
 
        //CoreDataInstance
        
        /*
        if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
            self.client = TWTRAPIClient(userID: userID)
        }
        */
        //refreshdata()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let logoutButton = UIBarButtonItem(title: "<Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationController?.navigationItem.rightBarButtonItem = logoutButton
        
        self.navigationController?.title = "Home Timeline"
        
        tableView.reloadData()
    }
    
// MARK: - Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataInstance.allObjects().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier:  "TweetCell") as! TweetTableViewCell
        cell.bindWithModel(withObject: self.CoreDataInstance.allObjects()[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
//MARK: - methods
    
    @objc func refreshdata() {
        DispatchQueue.main.async {
            ConnectionClient.instance.homeTimelineRequest()
        }

        tableView.reloadData()
        //tableView.refreshControl?.endRefreshing()
    }
    
    @objc func logout() {
        Twitter.sharedInstance().sessionStore.logOutUserID((client?.userID)!)
        UserDefaults.standard.removeObject(forKey: "sessionStore")
        //self.tweets = []
        self.navigationController?.popToRootViewController(animated: true)

    }
}

//MARK: - Async image loading
let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        self.image = nil
        
        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                }
            }
            
        }).resume()
    }
}
