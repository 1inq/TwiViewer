//
//  ConnectionClient.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 29.11.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit
import OAuthSwift
import WebKit
import Alamofire


class ConnectionClient : OAuth1Swift {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    static let UserLoggedInNotification = Notification(name: Notification.Name(rawValue: "UserLoggedInNotification"))
    
    var connectionStatus : Bool?
    var accessToken : String!
    var accessSecret: String!
    
    var loginSuccess: (()->())?
    var loginFailure: ((NSError)->())?
    
    static let callbackURL = "TwiViewer://oauth-callback"
    
    static let sharedManager = ConnectionClient(
        consumerKey: ApplicationCredentials.CONSUMERKEY,
        consumerSecret: ApplicationCredentials.CONSUMERSECRET,
        requestTokenUrl: ApplicationCredentials.REQUESTTOKENURLURL,
        authorizeUrl: ApplicationCredentials.AUTHORIZEURL,
        accessTokenUrl: ApplicationCredentials.ACCESSTOKENURLURL
    )
    

    func handle() {
        
        ConnectionClient.sharedManager.authorize(withCallbackURL: URL(string:ConnectionClient.callbackURL)!,
                                        success: { (credential, response, parameters) in
                                            print("Token:  ",credential.oauthToken)
                                            print("Secret: ",credential.oauthTokenSecret)
                                    
                                            self.accessToken = credential.oauthToken
                                            self.accessSecret = credential.oauthTokenSecret
                                            print(credential)
                                            print(parameters["user_id"]!)
                                            
                                            ConnectionClient.sharedManager.connectionStatus = true
                                            self.appDelegate.connectionStatus = true
                                            
                                            NotificationCenter.default.post(ConnectionClient.UserLoggedInNotification)
                                            
                                        },
                                        failure: { (error) in
                                            print(error.localizedDescription)
                                        }
        )
    }
    
    func deauthorize(){
        
        /*
        let dictionary : Dictionary = [kSecClass:kSecClassGenericPassword,
                                       kSecAttrService:ApplicationCredentials.REQUESTTOKENURLURL] as [CFString : Any]
        let status : OSStatus = SecItemDelete(dictionary as CFDictionary)
        */
        
        
        let dataTypes = Set([WKWebsiteDataTypeCookies,
                             WKWebsiteDataTypeLocalStorage, WKWebsiteDataTypeSessionStorage,
                             WKWebsiteDataTypeWebSQLDatabases, WKWebsiteDataTypeIndexedDBDatabases])
        
        WKWebsiteDataStore.default().removeData(ofTypes: dataTypes, modifiedSince: NSDate.distantPast, completionHandler: {})
        
        ConnectionClient.sharedManager.accessToken = nil
        ConnectionClient.sharedManager.accessSecret = nil
        ConnectionClient.sharedManager.connectionStatus = false
        appDelegate.connectionStatus = false
        
    }
    
    func logout() {
        ConnectionClient.sharedManager.connectionStatus = false
        appDelegate.connectionStatus = false
    }
    
    func homeTimeline(){
        Alamofire.request("https://api.twitter.com/1.1/statuses/home_timeline.json").responseJSON{ response  in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")
        }
        
    }
}
