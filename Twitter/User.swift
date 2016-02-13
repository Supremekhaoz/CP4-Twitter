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
        /*
        // data returned from the network response will typically be of type
        // NSData (which is a buffer of bytes)
        let responseData: NSData = // ... some value retrieved from the network response ...
        
        // Wrap our code in a do catch as our code might throw an exception which we need to handle
        do {
            // Start by converting the NSData to a dictionary - a dictionary for the entire response
            if let responseDictionary = try NSJSONSerialization.JSONObjectWithData(responseData,
                options:NSJSONReadingOptions(rawValue:0)) as? [String:AnyObject] {
                    
                    // Dip inside the response to find the "movies" key and get the array of movies
                    if let movies = responseDictionary["movies"] as? [AnyObject] {
                        
                        // Get each movie dictionary from the array of movies
                        for movie in movies {
                            
                            // Use the movie "title" key and "rating" key to get their values
                            if let title = movie["title"] as? String {
                                if let rating = movie["rating"] as? Double {
                                    print("Title:\(title), rating:\(rating)")
                                }
                            }
                        }
                    }
            }
        } catch {
            print("Error parsing JSON")
        }*/
        
        get {
            if _currentUser == nil {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
        
                if data != nil {
                    do {
                        if let dictionary = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions(rawValue:0)) as? NSDictionary {
                            _currentUser = User(dictionary: dictionary)
                        }
                    } catch {
                        print("Error parsing JSON")
                    }
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                //convert nsdictionary into nsdata
                let data2 : NSData = NSKeyedArchiver.archivedDataWithRootObject(user!.dictionary)
                do {
                    if let data = try NSJSONSerialization.JSONObjectWithData(data2, options: NSJSONReadingOptions(rawValue:0)) as? NSDictionary	 {
                        NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                    }
                } catch {
                    print("Error with JSON")
                }
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
