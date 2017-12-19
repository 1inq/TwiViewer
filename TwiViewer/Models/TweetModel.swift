//
//  TweetStruct.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 05.12.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import Foundation
import SwiftyJSON

class TweetModel {
    
    var id_str: String = ""
    var name: String = ""
    var screenName: String = ""
    var image: String = ""
    var text: String = ""
    var created_at: NSDate = NSDate(timeIntervalSince1970: 0)
    var imageData: NSData = NSData()
    
    init() {
        id_str = ""
        name = ""
        screenName = ""
        image = ""
        text = ""
        created_at = NSDate(timeIntervalSince1970: 0)
    }
    
    init(id_str: String, name: String, screenName: String, image: String, text: String, created_at: NSDate) {
        self.id_str = id_str
        self.name = name
        self.screenName = screenName
        self.image = image
        self.text = text
        self.created_at = created_at
    }
    
    init(withJson json: JSON) {
        if let username = json["user"]["name"].string { self.name = username}
        if let screenName = json["user"]["screen_name"].string {self.screenName = screenName}
        
        //Image Loading to CoreData
        if let image = json["user"]["profile_image_url_https"].string {
            self.image = image
            let url = URL(string: image)
            
            URLSession.shared.dataTask(with: url as! URL, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error ?? "No Error")
                    return
                }
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.imageData = data as! NSData
                })
                
            }).resume()
            
            
        }
        //
        
        if let text = json["text"].string { self.text = text}
        if let id_str = json["id_str"].string {self.id_str = id_str}
        if let created_at = json["created_at"].string {
            //Thu Dec 07 13:55:15 +0000 2017
            let format = "E MMM dd HH:mm:ss Z y"
            self.created_at = created_at.getDate(with:format)
        }
        
    }
}
