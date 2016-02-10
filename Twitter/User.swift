//
//  User.swift
//  Twitter
//
//  Created by Luis Liz on 2/9/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUser"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        
                if data != nil {
                    let dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
            }
        }

            return _currentUser
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                let data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
