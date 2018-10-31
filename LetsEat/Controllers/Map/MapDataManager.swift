//
//  MapDataManager.swift
//  LetsEat
//
//  Created by Roger Florat on 25/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation
import MapKit

class MapDataManager: DataManager {
    
    fileprivate var items:[RestaurantItem] = []
    
    var annotations:[RestaurantItem] {
        return items
    }
    
    func fetch(with completion: (_ annotations:[RestaurantItem]) -> ()) {
        let manager = RestaurantDataManager()
        manager.fetch(by: "Boston") { (items) in
            self.items = items
            completion(items)
        }
    }
    
    func currentRegion(latDelta:CLLocationDegrees, longDelta:CLLocationDegrees) -> MKCoordinateRegion {
        
        guard let item = items.first else { return MKCoordinateRegion() }
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        
        return MKCoordinateRegion(center: item.coordinate, span: span)
    }
    
}
