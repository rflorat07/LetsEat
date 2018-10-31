//
//  ReviewFormViewController.swift
//  LetsEat
//
//  Created by Roger Florat on 29/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class ReviewFormViewController: UITableViewController {
    
    @IBOutlet weak var ratingView: RatingView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tvReview: UITextView!
    
    var selectedRestaurantID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



private extension ReviewFormViewController {
    
    @IBAction func onSaveTapped(_ sender: Any) {
        
        var item = ReviewItem()
        
        item.title = tfTitle.text
        item.name = tfName.text
        item.customerReview = tvReview.text
        item.restaurantID = selectedRestaurantID
        item.rating = Float(ratingView.rating)
        
        let manager = CoreDataManager()
        manager.addReview(item)
        
        dismiss(animated: true, completion: nil)
    }
}

