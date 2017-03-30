//
//  ListOfType.swift
//  final_Movies
//
//  Created by Godfather on 12/27/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import Foundation


class ListOfType: NSObject {
    static var share = ListOfType()
    override init() { }
    var listMovie: [Genre] = []

    func listOfTypeMovie() {
        
    }
    
    func getDictionFromGenreList() -> [Int:String] {
        var dicGenre:[Int:String] = [Int:String]()
        
        if listMovie.count <= 0 {return dicGenre}
        
        for genre in listMovie {
            dicGenre[genre.id] = genre.name
        }
        return dicGenre
    }
}
