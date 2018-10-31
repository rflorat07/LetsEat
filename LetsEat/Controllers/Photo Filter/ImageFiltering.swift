//
//  ImageFiltering.swift
//  LetsEat
//
//  Created by Roger Florat on 29/10/2018.
//  Copyright © 2018 Roger Florat. All rights reserved.
//

import UIKit
import CoreImage

protocol ImageFiltering {
    func apply(filter:String, originalImage:UIImage) -> UIImage
}

protocol ImageFilteringDelegate:class {
    func filterSelected(item:FilterItem)
}

extension ImageFiltering {
    
    func apply(filter:String, originalImage:UIImage) -> UIImage {
        let initialCIImage = CIImage(image: originalImage, options: nil)
        let originalOrientation = originalImage.imageOrientation
        
        guard let ciFilter = CIFilter(name: filter) else {
            print("filter not found")
            return UIImage()
        }
        
        ciFilter.setValue(initialCIImage, forKey: kCIInputImageKey)
        
        let context = CIContext()
        let filteredCIImage = (ciFilter.outputImage)!
        let filteredCGImage = context.createCGImage(filteredCIImage, from: filteredCIImage.extent)
        
        return UIImage(cgImage: filteredCGImage!, scale: 1.0, orientation: originalOrientation)
    }
}

