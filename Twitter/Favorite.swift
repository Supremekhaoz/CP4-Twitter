//
//  Favorite.swift
//  Twitter
//
//  Created by Luis Liz on 2/14/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit

class Favorite: NSObject {
    var id: Int?
    var favorite: Bool?
    var favoriteCount: Int?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as! Int?
        favorite = dictionary["favorited"] as! Bool?
        favoriteCount = dictionary["favourites_count"] as! Int?
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Favorite] {
        var favorites = [Favorite]()
        
        for dictionary in array {
            favorites.append(Favorite(dictionary: dictionary))
        }
        
        return favorites
    }
}
