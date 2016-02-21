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
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var user_id: String?
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary

    var tweetsCount: String?
    var followerCount: Int?
    var followingCount: Int?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        user_id = (dictionary["id_str"] as? String?)!
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String
        
        tweetsCount = "\((dictionary["statuses_count"])!)"
        followerCount = dictionary["followers_count"] as! Int?
        followingCount = dictionary["friends_count"] as! Int?
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)

    }

    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        
                if data != nil {
                    let dictionary: NSDictionary?
                    do {
                        try dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                        _currentUser = User(dictionary: dictionary!)
                    } catch {
                        print(error)
                    }
                } else {
                    print("current user data is empty")
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            if let _ = _currentUser {
                var data: NSData?
                
                do {
                    try data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: .PrettyPrinted)
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                } catch {
                    print(error)
                }
            
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
