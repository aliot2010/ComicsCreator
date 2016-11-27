//
//  Page.swift
//  ComicsCreator
//
//  Created by alex L on 19.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit
import RealmSwift
class Page: Object {
    dynamic var pattern = 0
    var images = List<Image>()
    var booms = List<Boom>()
    var bubbles = List<Bubble>()
}
