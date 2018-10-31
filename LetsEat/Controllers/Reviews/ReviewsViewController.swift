//
//  ReviewsViewController.swift
//  LetsEat
//
//  Created by Roger Florat on 30/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import CoreData

class ReviewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedRestaurantID:Int?
    let manager = CoreDataManager()
    var data: [ReviewItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupDefaults()
    }
}

private extension ReviewsViewController {
    
    func initialize() {
        setupCollectionView()
    }
    
    func setupDefaults() {
        checkReviews()
    }
    
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.collectionViewLayout = flow
    }
    
    func checkReviews() {
        let viewController = self.parent as? RestaurantDetailViewController
        
        if let id = viewController?.selectedRestaurant?.restaurantID {
            if data.count > 0 { data.removeAll() }
            data = manager.fetchReviews(by: id)
            
            if data.count > 0 {
                collectionView.backgroundView = nil
            }
            else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Reviews")
                view.set(desc: "There are currently no reviews")
                
                collectionView.backgroundView = view
            }
            
            collectionView.reloadData()
        }
    }
}


extension ReviewsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reviewCell", for: indexPath) as! ReviewCell
        let item = data[indexPath.item]
        
        cell.lblName.text = item.name
        cell.lblTitle.text = item.title
        cell.lblReview.text = item.customerReview
        cell.lblDate.text = item.displayDate
            
        if let rating = item.rating { cell.ratingView.rating = CGFloat(rating) }
        
        return cell
    }
}

extension ReviewsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize {
        
        if data.count == 1 {
            let width = collectionView.frame.size.width - 14
            return CGSize(width: width, height: 208)
        }
        else {
            let width = collectionView.frame.size.width - 21
            return CGSize(width: width, height: 208)
        }
        
    }
}

