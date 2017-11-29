//
//  WelcomeViewController.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 29.11.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, LoginDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (!appDelegate.welcomeDelay) {
            self.continueLogin()
        }
    }
    func continueLogin() {
        appDelegate.welcomeDelay = false
        self.openLoginController()
    }
    
    func openLoginController() {
        self.performSegue(withIdentifier: "LoginSegue", sender: self)
    }
    
}
