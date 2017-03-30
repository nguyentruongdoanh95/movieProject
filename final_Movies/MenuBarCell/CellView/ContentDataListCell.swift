//
//  ContentDataListCell.swift
//  final_Movies
//
//  Created by Godfather on 12/28/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit

class ContentDataListCell: BaseCellCollection {
    
    func getForCell(data: Movie) {
        nameLabel.text = data.title
        guard let imgUrl = URL(string: data.poster_path) else {
            imageDisplay.image = nil
            return
        }
        imageDisplay.kf.indicatorType = .activity
        imageDisplay.kf.indicator?.startAnimatingView()
        imageDisplay.kf.setImage(with: imgUrl, placeholder: nil, options: [.transition(.fade(0.25)), .backgroundDecode], progressBlock: nil) { (img, error, cache, url) in
            if let img = img {
                DispatchQueue.main.async {
                    self.imageDisplay.image = img
                    self.imageDisplay.kf.indicator?.stopAnimatingView()
                }
            } else {
                DispatchQueue.main.async {
                    self.imageDisplay.image = nil
                    self.imageDisplay.kf.indicator?.stopAnimatingView()
                }
            }
        }
    }
    
    func getForCell(data: Cast) {
        nameLabel.text = data.name
        guard let imgUrl = URL(string: data.profile_path) else {
            imageDisplay.image = nil
            return
        }
        imageDisplay.kf.indicatorType = .activity
        imageDisplay.kf.indicator?.startAnimatingView()
        imageDisplay.kf.setImage(with: imgUrl, placeholder: nil, options: [.transition(.fade(0.25)), .backgroundDecode], progressBlock: nil) { (img, error, cache, url) in
            if let img = img {
                DispatchQueue.main.async {
                    self.imageDisplay.image = img
                    self.imageDisplay.kf.indicator?.stopAnimatingView()
                }
            } else {
                DispatchQueue.main.async {
                    self.imageDisplay.image = nil
                    self.imageDisplay.kf.indicator?.stopAnimatingView()
                }
            }
        }
    }
    override func setupInCell() {
        autoLayout()
    }
    let imageDisplay: UIImageView = {
        let img         = UIImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let nameLabel: UILabel = {
        let lbl             = UILabel()
        lbl.font            = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment   = .left
        lbl.numberOfLines   = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    func autoLayout() {
        addSubview(imageDisplay)
        addConstraintsWithVSF(formatString: "H:|-8-[v0]|", views: imageDisplay)
        addConstraintsWithVSF(formatString: "V:|-8-[v0]-8-|", views: imageDisplay)
        imageDisplay.addSubview(nameLabel)
        imageDisplay.addConstraintsWithVSF(formatString: "H:|[v0]|", views: nameLabel)
        imageDisplay.addConstraintsWithVSF(formatString: "V:[v0(24)]|", views: nameLabel)
    }
    
}
