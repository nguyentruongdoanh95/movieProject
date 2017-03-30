//
//  BaseCell.swift
//  final_Movies
//
//  Created by Godfather on 12/23/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit

class BaseCellCollection: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInCell()
    }
    func setupInCell() { }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
