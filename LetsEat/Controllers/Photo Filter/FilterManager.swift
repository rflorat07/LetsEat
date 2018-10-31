//
//  FilterManager.swift
//  LetsEat
//
//  Created by Roger Florat on 29/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

class FilterManager: DataManager {
    
    func fetch(completionHandler:(_ items:[FilterItem]) -> Void) {
        var items:[FilterItem] = []
        
        for data in load(file: "FilterData") {
            items.append(FilterItem(dict: data))
        }
        
        completionHandler(items)
    }
}
