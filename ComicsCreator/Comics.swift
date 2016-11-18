//
//  Comics.swift
//  ComicsCreator
//
//  Created by alex L on 17.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit
import RealmSwift

class Comics: Object {
    dynamic var name = ""
    dynamic var pathToFile = ""
    dynamic var comicsId = ""
    
    override public static func primaryKey() -> String?{
        return "comicsId"
    }
    
}
