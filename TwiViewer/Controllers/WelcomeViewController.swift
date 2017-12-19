//
//  WelcomeViewController.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 29.11.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON

class WelcomeViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let CoreDataInstance = TweetsCData.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("!WelcomeController was loaded!")

        //if appDelegate.sessionStore == nil {
            let logInButton = TWTRLogInButton(logInCompletion: { session, error in
                if (session != nil) {
                    print("signed in as \(session?.userName)");
                    self.appDelegate.sessionStore = session
                    self.appDelegate.saveSessionStore()
                    
                    if let userID = Twitter.sharedInstance().sessionStore.session()?.userID {
                        let client = TWTRAPIClient(userID: userID)
                    }
                    
                    ConnectionClient.instance.homeTimelineRequest()
                    self.navigationController?.popToRootViewController(animated: true)
                    
                    self.openHome()
                } else {
                    print("error: \(error?.localizedDescription)");
                }
            })
                logInButton.center = self.view.center
                self.view.addSubview(logInButton)
            /*
            } else {
                if !self.appDelegate.retriveSessionStore()  {print("Fail during retruve storeSession in WelcomeController)")}
                self.navigationController?.popToRootViewController(animated: true)
            }
            */
        //NotificationCenter.default.addObserver(self, selector: #selector(continueLogin), name:ConnectionClient.UserLoggedInNotification.name, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - segues
    func openHome() {
        var storyboard = self.storyboard
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeController")
        self.navigationController?.pushViewController(homeViewController!, animated: true)
    }
}
