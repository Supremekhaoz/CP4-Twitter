//
//  TwitterClient.swift
//  CP4-Twitter
//
//  Created by Luis Liz on 2/8/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "CTd3GuzEPB9rPlJ3B3ROQtC9N"
let twitterConsumerSecret = "jb1VdhYAka2XEtLnQZEkdgmGnrdD7sfUNJpVcGm1Uox004CLY8"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
}
