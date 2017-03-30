//
//  MenuBarCell.swift
//  final_Movies
//
//  Created by Godfather on 12/23/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit

class MenuBarCell: BaseCellCollection {
    override func setupInCell() {
        backgroundColor = .black
        setupAutoLayout()
    }
    
    let nameOptionLabel: UILabel = {
        let lbl             = UILabel()
        lbl.textAlignment   = .center
        lbl.textColor       = .white
        lbl.font            = UIFont.systemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
   
    private func setupAutoLayout(){
        addSubview(nameOptionLabel)
        nameOptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive  = true
        nameOptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive  = true
        nameOptionLabel.heightAnchor.constraint(equalToConstant: 24).isActive           = true
       
    }
}
