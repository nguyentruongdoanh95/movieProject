//
//  OfMoive.swift
//  final_Movies
//
//  Created by Godfather on 12/28/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import Foundation
import Alamofire
class OfMovie: NSObject {
    
    static var share = OfMovie()
    override init() {}
    
    func getListMovie(page: Int,type: String, responses: @escaping (_ movies:[Movie]?)->()) {
        let param:[String:Any] = [
            "api_key" : v3_api_key,
            "language" : lg_vi,
            "page" : page
        ]
        
        var listMovie:[Movie] = [Movie]()
        Alamofire.request("\(v3_api_movie)\(type)", method: .post, parameters: param)
            .responseJSON(queue: DispatchQueue.global(), completionHandler: { (response) in
                if let result = response.result.value as? Dictionary<String, Any> {
                    if let jsonDataList = result["results"] as? Array<Dictionary<String, Any>>, jsonDataList.count > 0 {
                        for jsonData in jsonDataList {
                            if let movie = Movie(jsonData: jsonData) {
                                listMovie.append(movie)
                            }
                        }
                    }
                }
                responses(listMovie)
            })
    }
    
    //  Thông tin film
    func movieDetail(id: Int, response: @escaping (_ movie: MovieDetail?) -> () ) {
        Alamofire.request("\(v3_api_movie)\(id)?api_key=\(v3_api_key)&language=\(lg_vi)", method: .get)
            .responseJSON(queue: DispatchQueue.global()) { (resultJSON) in
                var detail:MovieDetail?
                if let result = resultJSON.result.value as? Dictionary<String, Any> {
                    if let movieDetail = MovieDetail(jsonData: result) {
                        detail = movieDetail
                    }
                }
                response(detail)
        }
    }
    //  Get movies theo id của film
    func getVideosByMovieId(id: Int, response: @escaping (_ videos: [Video]?) -> () ) {
        var videos:[Video] = [Video]()
        Alamofire.request("\(v3_api_movie)\(id)/videos?api_key=\(v3_api_key)&language=\(lg_us)", method: .get)
            .responseJSON(queue: DispatchQueue.global()) { (resultJSON) in
                if let response = resultJSON.result.value as? Dictionary<String, Any> {
                    if let videosData = response["results"] as? Array<Dictionary<String, Any>>, videosData.count > 0 {
                        for videoData in videosData {
                            if let video = Video(jsonData: videoData) {
                                videos.append(video)
                            }
                        }
                    }
                }
                response(videos)
        }
    }
    
//    func searchMovie(searchText: String,page: Int, response: @escaping (_ movies:[Movie]?)->()) {
//        let searchHTML = searchText.html
//        var movies:[Movie] = [Movie]()
//        
//        Alamofire.request("\(v3_api)search/multi?api_key=303078be49b430148248d15a66718807&language=vi-VN&query=\(searchHTML)&include_adult=false&page=\(page)")
//            .responseJSON(queue: DispatchQueue.global()) { (result) in
//                if let response = result.result.value as? JSONData {
//                    if let moviesData = response["results"] as? [JSONData], moviesData.count > 0 {
//                        for movieData in moviesData {
//                            if let movie = Movie(jsonData: movieData) {
//                                movies.append(movie)
//                            }
//                        }
//                    }
//                    
//                }
//                response(movies)
//        }
//    }
    // Phim tương tự
    func getSimilarMoviesBy(movieId: Int, page: Int, response: @escaping (_ movies:[Movie]?)->()) {
        var movies:[Movie] = [Movie]()
        Alamofire.request("\(v3_api_movie)\(movieId)/similar?api_key=b9dc235688b5a5ddd138c2f905b7841a&language=vi-VN&include_adult=true&page=\(page)")
            .responseJSON(queue: DispatchQueue.global()) { (result) in
                
                if let response = result.result.value as? Dictionary<String, Any> {
                    if let moviesData = response["results"] as? Array<Dictionary<String, Any>>, moviesData.count > 0 {
                        for movieData in moviesData {
                            if let movie = Movie(jsonData: movieData) {
                                movies.append(movie)
                            }
                        }
                    }
                }
                response(movies)
        }
    }
    // Phim được đề xuất
    func getRecommendMoviesBy(movieId: Int, page: Int, response: @escaping (_ movies:[Movie]?)->()) {
        var movies:[Movie] = [Movie]()
        Alamofire.request("\(v3_api_movie)\(movieId)/recommendations?api_key=b9dc235688b5a5ddd138c2f905b7841a&language=vi-VN&include_adult=true&page=\(page)")
            .responseJSON(queue: DispatchQueue.global()) { (result) in
                
                if let response = result.result.value as? Dictionary<String, Any> {
                    if let moviesData = response["results"] as? Array<Dictionary<String, Any>>, moviesData.count > 0 {
                        for movieData in moviesData {
                            if let movie = Movie(jsonData: movieData) {
                                movies.append(movie)
                            }
                        }
                    }
                    
                }
                response(movies)
        }
    }
    // Diễn viên
    func getCastListBy(movieId: Int, page: Int, response: @escaping (_ movies:[Cast]?)->()) {
        var castList:[Cast] = [Cast]()
        Alamofire.request("\(v3_api_movie)\(movieId)/credits?api_key=b9dc235688b5a5ddd138c2f905b7841a&language=vi-VN&page=\(page)")
            .responseJSON(queue: DispatchQueue.global()) { (result) in
                
                if let response = result.result.value as? Dictionary<String, Any> {
                    if let castListData = response["cast"] as? Array<Dictionary<String, Any>>, castListData.count > 0 {
                        for castData in castListData {
                            if let cast = Cast(jsonData: castData) {
                                castList.append(cast)
                            }
                        }
                    }
                    
                }
                response(castList)
        }
    }
    
    func getMovieListBy(castId: Int, page: Int, response: @escaping (_ movies:[Movie]?)->()) {
        var movies:[Movie] = [Movie]()
        
        Alamofire.request("\(v3_api)discover/movie?api_key=b9dc235688b5a5ddd138c2f905b7841a&language=\(lg_vi)&sort_by=vote_average.desc&include_adult=false&include_video=true&page=\(page)&primary_release_date.gte=2000-01-01&vote_average.gte=0&vote_average.lte=9.9&with_cast=\(castId)")
            .responseJSON(queue: DispatchQueue.global()) { (result) in
                
                if let response = result.result.value as? Dictionary<String, Any> {
                    if let moviesData = response["results"] as? Array<Dictionary<String, Any>>, moviesData.count > 0 {
                        for movieData in moviesData {
                            if let movie = Movie(jsonData: movieData) {
                                movies.append(movie)
                            }
                        }
                    }
                    
                }
                response(movies)
        }
    }

}
