//
//  Constant.swift
//  final_Movies
//
//  Created by Godfather on 12/27/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit

// API Link
let v3_api = "https://api.themoviedb.org/3/"
let v3_api_key = "b9dc235688b5a5ddd138c2f905b7841a"
let v4_api = "https://api.themoviedb.org/4/"
let v4_api_key = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiOWRjMjM1Njg4YjVhNWRkZDEzOGMyZjkwNWI3ODQxYSIsInN1YiI6IjU4NDhmYzA1YzNhMzY4MTQxYTAxMDZlZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LnRFudmZHbGWVCV4uXfffYW7sPXaJonR1kKXsYPTr-o"
let v3_api_movie = "\(v3_api)movie/"
let lg_us = "en-US"
let lg_vi = "vi-VN"


//Image
let img_api                 = "https://image.tmdb.org/t/p/"
let backdrop_size_key       = "w780"
let backdrop_size           = 780
let logo_size_key           = "w500"
let logo_size:CGFloat       = 500
let poster_size_key =       "w500"
let poster_size:CGFloat     = 500
let profile_size_key        = "w185"
let profile_size:CGFloat    = 185
let still_size_key          = "w300"
let still_size:CGFloat      = 300

extension Double {
    func convertToStringWithOneDecimal() -> String {
        return String(format: "%.1f", self)
    }
}
