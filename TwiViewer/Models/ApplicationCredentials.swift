//
//  ApplicationCredentials.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 29.11.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit

class ApplicationCredentials {
    var consumerKey : String!
    var consumerSecret : String!
    var requestTokenURL : String!
    var authorizeURL : String!
    var accessTokenURL: String!
    
    static let credentials = ApplicationCredentials()
    
    init() {
        consumerKey = "w1xOoTcsyrjzpXVETeD2mCryb"
        consumerSecret = "HUsQCFhlCOwGPyTI884S7SuybAZ0VT7LC47p3JwCgaMH9Tb7xY"
        requestTokenURL = "https://api.twitter.com/oauth/request_token"
        authorizeURL = "https://api.twitter.com/oauth/authorize"
        accessTokenURL = "https://api.twitter.com/oauth/access_token"
    }
}
