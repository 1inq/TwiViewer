//
//  TweetStruct.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 05.12.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import Foundation

class TweetStruct {
    
    var id_str: String
    var name: String
    var screenName: String
    var image: String
    var text: String
    var created_at: NSDate
    
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
}
