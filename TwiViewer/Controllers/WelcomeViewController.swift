//
//  WelcomeViewController.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 29.11.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit
import TwitterKit

class WelcomeViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                print("signed in as \(session?.userName)");
                
                self.openHome()
            } else {
                print("error: \(error?.localizedDescription)");
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)

        //NotificationCenter.default.addObserver(self, selector: #selector(continueLogin), name:ConnectionClient.UserLoggedInNotification.name, object: nil)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.continueLogin()
    }
    
    @objc func continueLogin() {
        //appDelegate.welcomeDelay = false
        print("Access Secret:",ConnectionClient.sharedManager.accessSecret)
        print("Equality: ",ConnectionClient.sharedManager.accessSecret == nil)
        if ConnectionClient.sharedManager.accessSecret == nil {
            
            
            self.openLoginController()
        } else {
            self.openHome()
        }
        
        /*
        if (ConnectionClient.sharedManager.accessSecret != nil) {
            self.openHome()
        }
        */
    }
    
    // MARK -  segues 
    func openHome() {
        self.performSegue(withIdentifier: "HomeSegue", sender: self)
        /*
        var homeController = HomeViewController()
        self.pushViewController(homeController, animated: true)
         */
    }
    
    func openLoginController() {
        self.performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: ConnectionClient.UserLoggedInNotification.name, object: nil)
    }
    
    
    
}
