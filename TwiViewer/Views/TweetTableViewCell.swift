//
//  TweetTableViewCell.swift
//  TwiViewer
//
//  Created by Александр Сорокин on 05.12.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    var innerView: UIView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with view: UIView){
        innerView = view
        //resize cell
    }
    
    

}
