//
//  ApplicationCredentials.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 29.11.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit

class ApplicationCredentials {
    static let CONSUMERKEY = "w1xOoTcsyrjzpXVETeD2mCryb"
    static let  CONSUMERSECRET = "HUsQCFhlCOwGPyTI884S7SuybAZ0VT7LC47p3JwCgaMH9Tb7xY"
    static let REQUESTTOKENURLURL = "https://api.twitter.com/oauth/request_token"
    static let AUTHORIZEURL = "https://api.twitter.com/oauth/authorize"
    static let ACCESSTOKENURLURL = "https://api.twitter.com/oauth/access_token"
    
    static let credentials = ApplicationCredentials()
    
    init() {
    }
}
