//
//  Tools.swift
//  ComicsCreator
//
//  Created by alex L on 19.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit

class Tools: NSObject {
    
    public static var comixPatternsImages = [ UIImage(named: "single"), UIImage(named: "dual"), UIImage(named: "dual1"), UIImage(named: "three") , UIImage(named: "three1"), UIImage(named: "three2"), UIImage(named: "four")]
    public static let comicsPatternsById = [ "SingleImagePageView", "DualImagePageView",  "DualImagePageView1", "ThreeImagePageView", "ThreeImagePageView1", "ThreeImagePageView2", "FourImagePageView" ]
    public static func getTimeAsString()->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yy-hh-mm-ss-SSS"
        return dateFormatter.string(from: NSDate() as Date)
    }
}
