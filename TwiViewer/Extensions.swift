//
//  Extensions.swift
//  TwiViewer
//
//  Created by Alex S. on 19.12.2017.
//  Copyright © 2017 Александр Сорокин. All rights reserved.
//

import Foundation

extension String {
    
    func getDate(with fromat: String) -> NSDate {
        let dateFormatter = DateFormatter()
        //"E MMM dd HH:mm:ss Z y"
        dateFormatter.dateFormat = fromat
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 6*60*60)
        let dateObj : NSDate = dateFormatter.date(from: self) as! NSDate
        return dateObj
    }
}
