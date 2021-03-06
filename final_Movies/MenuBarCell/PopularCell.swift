//
//  PopularCell.swift
//  final_Movies
//
//  Created by Godfather on 12/27/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit

class PopularCell: TopRatedCell {
    override func getDataForAPI() {
        if isFirstLoad {
            self.startLoading()
            ForAPI.share.getListMovie(page: page, type: TypeOfMovie.popular.rawValue, responses: { (movieList) in
                for item in movieList {
                    self.arrMovie.append(item)
                }
                DispatchQueue.main.async {
                    self.collectionview.reloadData()
                    self.stopLoading()
                }
            })
        }
    }
}
