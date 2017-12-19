//
//  TweetTableViewCell.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 05.12.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet var personalImageView: UIImageView?
    @IBOutlet var nameLabel: UILabel?
    @IBOutlet var screenNameLabel: UILabel?
    @IBOutlet var tweetTextLabel: UILabel?
    @IBOutlet var created_at: UILabel?
    
    func bindWithModel(withObject object: Tweet) {
    
        let tweetObjFromCD = object
        
        self.nameLabel?.text = tweetObjFromCD.text
        self.screenNameLabel?.text = "@" + tweetObjFromCD.screenName!
        self.nameLabel?.text = tweetObjFromCD.name
        
        //self.personalImageView?.loadImageUsingCache(withUrl: tweetObjFromCD.image!)
        
        self.personalImageView?.image = UIImage(data: tweetObjFromCD.imageData!)
    
        self.tweetTextLabel?.text = tweetObjFromCD.text
        self.tweetTextLabel?.numberOfLines = 0
        self.tweetTextLabel?.sizeToFit()
        self.tweetTextLabel?.layer.cornerRadius = 5
        
        let df = DateFormatter()
        df.dateFormat = "hh:mm dd/MM"
        let dateString = df.string(from: tweetObjFromCD.created_at as! Date)
        self.created_at?.text = dateString
        
        //self.imageView?.image
        //self.textLabel?.text = ""
    }
}
