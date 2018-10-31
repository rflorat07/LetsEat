//
//  RestaurantViewController.swift
//  CollectionViewTest
//
//  Created by Craig Clayton on 6/30/17.
//  Copyright © 2017 Cocoa Academy. All rights reserved.
//


import UIKit

class RestaurantViewController: UIViewController {
    
    var manager = RestaurantDataManager()
    var selectedRestaurant:RestaurantItem?
    var selectedCity:LocationItem?
    var selectedType:String?
    
    fileprivate let minItemSpacing: CGFloat = 7
    
    @IBOutlet var collectionView:UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initialize()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator
        : UIViewControllerTransitionCoordinator) {
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case Segue.showDetail.rawValue:
                showRestaurantDetail(segue: segue)
            default: print("Segue not added")
            }
        }
    }
}

// MARK: Private Extension
private extension RestaurantViewController {
    
    func initialize() {
        createData()
        setupTitle()
        if Device.isPad{ setupCollectionView() }
    }
    
    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        
        collectionView.collectionViewLayout = flow
    }
    
    func createData() {
        guard let location = selectedCity?.city, let filter = selectedType else { return }
        manager.fetch(by: location, with: filter) { _ in
            
            if manager.numberOfItems() > 0 {
                collectionView.backgroundView = nil
            }
            else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Restaurants")
                view.set(desc: "No restaurants found.")
                
                collectionView.backgroundView = view
            }
            
            collectionView.reloadData()
        }
    }
    
    func setupTitle() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        if let city = selectedCity?.city, let state = selectedCity?.state {
            title = "\(city.uppercased()), \(state.uppercased())"
        }
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func showRestaurantDetail(segue:UIStoryboardSegue) {
        if let viewController = segue.destination as? RestaurantDetailViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            selectedRestaurant = manager.restaurantItem(at: index)
            
            dump(selectedRestaurant)
            
            viewController.selectedRestaurant = selectedRestaurant
            
        }
    }
}

// MARK: UICollectionViewDataSource
extension RestaurantViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "restaurantCell", for: indexPath) as! RestaurantCell
        let item = manager.restaurantItem(at: indexPath)
        
        if let name = item.name { cell.lblTitle.text = name }
        if let cuisine = item.subtitle { cell.lblCuisine.text = cuisine }
        if let image = item.imageURL {
            if let url = URL(string: image) {
                let data = try? Data(contentsOf: url)
                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.imgRestaurant.image = UIImage(data: imageData)
                    }
                }
            }
        }
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    
}

extension RestaurantViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if Device.isPad {
            let factor = traitCollection.horizontalSizeClass == .compact ? 2:3
            let screenRect = collectionView.frame.size.width
            let screenWidth = screenRect - (CGFloat(minItemSpacing) * CGFloat(factor + 1))
            let cellWidth = screenWidth / CGFloat(factor)
            
            return CGSize(width: cellWidth, height: 325)
            
        }
        else {
            let screenRect = collectionView.frame.size.width
            let screenWidth = screenRect - 10
            let cellWidth = screenWidth
            
            return CGSize(width: cellWidth, height: 325)
        }
    }
}
