//
//  Video.swift
//  final_Movies
//
//  Created by Godfather on 12/28/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import Foundation

enum VideoType : String {
    case trailer    = "Trailer"
    case teaser     = "Teaser"
    case featurette = "Featurette"
}


struct Video {
    var id:     String
    var key:    String
    var name:   String = "Trailer 1"
    var size:   Int = 720
    var site:   String = ""
    var type :  VideoType = .trailer
    
    init?(jsonData: Dictionary<String, Any>) {
        guard let id    = jsonData["id"]    as? String else { return nil }
        guard let key   = jsonData["key"]   as? String else { return nil }
        
        self.id     = id
        self.key    = key
        
        if let name = jsonData["name"] as? String{
            self.name = name
        }
        
        if let size = jsonData["size"] as? Int {
            self.size = size
        }
        
        if let site = jsonData["site"] as? String, !site.isEmpty {
            self.site = site
        }
        
        if let type = jsonData["type"] as? String {
            switch type {
            case VideoType.teaser.rawValue:
                self.type = .trailer
            case VideoType.featurette.rawValue:
                self.type = .featurette
            default:
                self.type = .trailer
            }
        }
        
    }
}
