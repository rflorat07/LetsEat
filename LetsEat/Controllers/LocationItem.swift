//
//  LocationItem.swift
//  LetsEat
//
//  Created by Roger Florat on 26/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

struct LocationItem {
    var state: String?
    var city: String?
}

extension LocationItem {
    init(dict:[String:AnyObject]) {
        self.state  = dict["state"] as? String
        self.city = dict["city"] as? String
    }
    
    var full: String {
        guard let city = self.city, let state = self.state else { return "" }
        return "\(city), \(state)"
    }
}
