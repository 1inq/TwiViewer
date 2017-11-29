//
//  ConnectionClient.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 29.11.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit
import OAuthSwift

class ConnectionClient : OAuth1Swift {
    
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    //static let callbackURL = "https://github.com/1inq"
    static let callbackURL = "TwiViewer://oauth-callback"
    
    static let sharedManager = ConnectionClient(
        consumerKey: ApplicationCredentials.credentials.consumerKey,
        consumerSecret: ApplicationCredentials.credentials.consumerSecret,
        requestTokenUrl: ApplicationCredentials.credentials.requestTokenURL,
        authorizeUrl: ApplicationCredentials.credentials.authorizeURL,
        accessTokenUrl: ApplicationCredentials.credentials.accessTokenURL)

    static func handle() {
        
        /*
        sharedManager.authorizeURLHandler = TestHandle(callbackURL: callbackURL,
                                                       authorizeURL: ApplicationCredentials.credentials.authorizeURL,
                                                       version: .oauth1)
        */
        
        sharedManager.authorize(withCallbackURL: URL(string:callbackURL)!,
                                        success: { (credential, response, parameters) in
                                            print(credential.oauthToken)
                                            print(credential.oauthTokenSecret)
                                            print(parameters["user_id"]!)
                                        },
                                        failure: { (error) in
                                            print(error.localizedDescription)
                                        }
        )
    }
}
