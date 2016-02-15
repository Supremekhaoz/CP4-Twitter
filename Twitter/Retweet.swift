//
//  Retweet.swift
//  Twitter
//
//  Created by Luis Liz on 2/14/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit

class Retweet: NSObject {
    var id: Int?
    var retweeted: Bool?
    var retweetedCount: Int?
    
    init(dictionary: NSDictionary) {
        id = dictionary["id"] as! Int?
        retweeted = dictionary["retweeted"] as! Bool?
        retweetedCount = dictionary["retweet_count"] as! Int?
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Retweet] {
        var retweets = [Retweet]()
        
        for dictionary in array {
            retweets.append(Retweet(dictionary: dictionary))
        }
        
        return retweets
    }

}
