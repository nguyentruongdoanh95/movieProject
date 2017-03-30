//
//  AutoLayout.swift
//  final_Movies
//
//  Created by Godfather on 12/23/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit


func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    
    let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)
    
    UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
}

extension UIView {
    func addConstraintsWithVSF(formatString: String, views: UIView...){
        var dict: Dictionary<String, UIView> = [:]
        for (index, name) in views.enumerated() {
            let key:String     = "v\(index)"
                dict[key]      = name
        }
       addConstraints(NSLayoutConstraint.constraints(withVisualFormat: formatString, options: NSLayoutFormatOptions(), metrics: nil, views: dict))
    }
    
}


