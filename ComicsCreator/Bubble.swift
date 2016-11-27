//
//  Bubble.swift
//  ComicsCreator
//
//  Created by alex L on 27.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit
import RealmSwift
class Bubble: Object {
    dynamic var imageName = "boom-copy"
    
    dynamic var boomX = 30.0
    dynamic var boomY = 30.0
    
    dynamic var scaleX = 1.0
    dynamic var scaleY = 1.0
    
    dynamic var text = "Arrgghh"
}
