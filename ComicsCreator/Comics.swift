//
//  Comics.swift
//  ComicsCreator
//
//  Created by alex L on 19.11.16.
//  Copyright © 2016 alex L. All rights reserved.
//

import UIKit
import RealmSwift
class Comics : Object{
    dynamic var title = ""
    dynamic var cover = ""
    var pages = List<Page>()
}

