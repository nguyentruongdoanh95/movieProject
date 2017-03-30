//
//  Cast.swift
//  final_Movies
//
//  Created by Godfather on 12/28/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import Foundation


struct Cast {
    var id:             Int
    var character:      String
    var credit_id:      String
    var name:           String
    var profile_path:   String = ""
    
    init?(jsonData: Dictionary<String, Any>) {
        guard let id        = jsonData["id"]        as? Int     else { return nil }
        guard let character = jsonData["character"] as? String  else { return nil }
        guard let credit_id = jsonData["credit_id"] as? String  else { return nil }
        guard let name      = jsonData["name"]      as? String  else { return nil }
        
        self.id         = id
        self.character  = character
        self.credit_id  = credit_id
        self.name       = name
        
        if let profile_path = jsonData["profile_path"] as? String, !profile_path.isEmpty {
            self.profile_path = "\(img_api)\(profile_size_key)\(profile_path)"
        }
    }
}
