//
//  ForAPI.swift
//  final_Movies
//
//  Created by Godfather on 12/27/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit
import Alamofire

class ForAPI: NSObject {
    static var share = ForAPI()
    override init() { }
    
    func getListMovie(page: Int, type: String, responses: @escaping (_ movies: [Movie])->()) {
        
        let parameters:[String:Any] = [
            "api_key" : v3_api_key,
            "language" : lg_vi,
            "page" : page
        ]
        
        var listMovie: [Movie] = []
        Alamofire.request("\(v3_api_movie)\(type)", method: .post, parameters: parameters).responseJSON(queue: DispatchQueue.global()) { (response) in
            if let results = response.result.value as? Dictionary<String, AnyObject> {
                if let jsonDataList = results["results"] as? Array<Dictionary<String, AnyObject>>, jsonDataList.count > 0 {
                    for jsonData in jsonDataList {
                        let movie = Movie(jsonData: jsonData)
                        listMovie.append(movie!)
                    }
                }
            }
                responses(listMovie)
        }
    }
    
    
   
}

