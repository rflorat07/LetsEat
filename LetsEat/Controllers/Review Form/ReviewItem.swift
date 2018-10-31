//
//  ReviewItem.swift
//  LetsEat
//
//  Created by Roger Florat on 29/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import Foundation

struct ReviewItem {
    
    var title: String?
    var rating: Float?
    var name: String?
    var customerReview: String?
    var date: Date?
    var restaurantID: Int?
    var uuid = UUID().uuidString
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yy"
        guard let reviewDate = date else { return "" }
        
        return formatter.string(from: reviewDate as Date)
    }
}

extension ReviewItem {
    
    init(data:Review) {
        self.title = data.title
        self.customerReview = data.customerReview
        self.name = data.name
        self.restaurantID = Int(data.restaurantID)
        self.rating = data.rating
        if let uuid = data.uuid { self.uuid = uuid }
        if let reviewDate = data.date { self.date = reviewDate }
    }
}
