//
//  TestHandle.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 29.11.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import Foundation
import OAuthSwift

enum AccessTokenResponse {
    case accessToken(String), code(String, state:String?), error(String,String), none
    
    var responseType: String {
        switch self {
        case .accessToken:
            return "token"
        case .code:
            return "code"
        case .error:
            return "code"
        case .none:
            return "code"
        }
    }
}

class TestHandle: NSObject, OAuthSwiftURLHandlerType {
    
    let callbackURL: String
    let authorizeURL: String
    let version: OAuthSwiftCredential.Version
    
    var accessTokenResponse: AccessTokenResponse?
    
    var authorizeURLComponents: URLComponents? {
        return URLComponents(url: URL(string: self.authorizeURL)!, resolvingAgainstBaseURL: false)
    }
    
    init(callbackURL: String, authorizeURL: String, version: OAuthSwiftCredential.Version) {
        self.callbackURL = callbackURL
        self.authorizeURL = authorizeURL
        self.version = version
    }
    
    @objc func handle(_ url: URL) {
        handleV1(url)
    }
    
    func handleV1(_ url: URL) {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        
        if let queryItems = urlComponents?.queryItems {
            for queryItem in queryItems {
                if let value = queryItem.value , queryItem.name == "oauth_token" {
                    let url = "\(self.callbackURL)?oauth_token=\(value)"
                    OAuthSwift.handle(url: URL(string: url)!)
                }
            }
        }
        
        urlComponents?.query = nil
        
        if urlComponents != authorizeURLComponents  {
            print("bad authorizeURL \(url), must be \(authorizeURL)")
            return
        }
    }
}
