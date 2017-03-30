//
//  BaseModel.swift
//  final_Movies
//
//  Created by Godfather on 12/27/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import Foundation


protocol BaseModel {
    var id:                 Int { get }
    var title:              String { get set }      // Tên film
    var poster_path:        String { get set }
    var backdrop_path:      String { get set }      // Hình film
    var original_title:     String { get }
    var original_language:  String { get }
    var hasVideo:           Bool { get set }
    var release_date:       String { get set }
    var vote_average:       Double { get set }      // Điểm IMDB
    var vote_count:         Int { get set }
    var popularity:         Double { get set }      // Phổ biến
    var adult:              Bool { get set }
    
    init?(jsonData: Dictionary<String, Any>)
}

