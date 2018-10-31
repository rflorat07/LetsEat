//
//  ReviewCell.swift
//  LetsEat
//
//  Created by Roger Florat on 30/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var ratingView: RatingView!
}
