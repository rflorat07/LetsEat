//
//  ExploreItem.swift
//  LetsEat
//
//  Created by Roger Florat on 25/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

struct ExploreItem {
    var name: String?
    var image: String?
}

extension ExploreItem {
    init(dict:[String:AnyObject]) {
        self.name  = dict["name"]  as? String
        self.image = dict["image"] as? String
    }
}
