//
//  innerView.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 05.12.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit

class InnerView: UIView {

    var name: UILabel?
    var screenName: UILabel?
    var image: UIImageView?
    var text: UILabel?
    
    init(with object: Tweet) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        name = UILabel(frame: CGRect(x: 30, y: 5, width: 10, height: 10))
        name?.font = UIFont(name: "System", size: 12)
        name?.textColor = UIColor.black
        name?.text = object.name
        
        screenName = UILabel(frame: CGRect(x: 45, y: 5, width: 10, height: 10))
        screenName?.font = UIFont(name: "System", size: 12)
        screenName?.textColor = UIColor.gray
        screenName?.text = object.screenName
        
        image = UIImageView()
        image?.frame = CGRect(x: 5, y: 5, width: 20, height: 20)
        
        text = UILabel(frame: CGRect(x: 5, y: 30, width: 200, height: 50))
        text?.textColor =  UIColor.black
        text?.font = UIFont(name: "System", size: 12)
        text?.text = object.text
        
        self.addSubview(self.image!)
        self.addSubview(self.name!)
        self.addSubview(self.screenName!)
        self.addSubview(self.text!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
