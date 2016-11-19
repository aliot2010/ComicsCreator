//
//  Tools.swift
//  ComicsCreator
//
//  Created by alex L on 19.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class Tools: NSObject {
    public static func getTimeAsString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yy-hh-mm-ss-SSS"
        return dateFormatter.string(from: NSDate() as Date)
    }
}
