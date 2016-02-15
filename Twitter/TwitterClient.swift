//
//  TwitterClient.swift
//  Twitter
//
//  Created by Luis Liz on 2/9/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "CTd3GuzEPB9rPlJ3B3ROQtC9N"
let twitterConsumerSecret = "jb1VdhYAka2XEtLnQZEkdgmGnrdD7sfUNJpVcGm1Uox004CLY8"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
            }
        return Static.instance
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {(requestToken:BDBOAuth1Credential!) -> Void in
            
            print("Got the request")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            }) {(failure: NSError!) -> Void in
                print("Failed to get request token")
        }
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweet: [Tweet]?, error: NSError?)-> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: params,
            success: { (operation: NSURLSessionDataTask?, response: AnyObject?) -> Void in
                var tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
                for tweet in tweets {
                    print("tweet: \(tweet.user?.profileImageUrl!)")
                }
                completion(tweet: tweets, error: nil)
            },
            
            failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Failed to get the infomation")
                
                completion(tweet: nil, error: error)
                
                self.loginCompletion!(user: nil, error: error)
        })
        
    }
    func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token",
            method: "POST",
            requestToken: BDBOAuth1Credential(queryString: url.query),
            success: {(accessToken: BDBOAuth1Credential!) -> Void in
                print("got access token")
                TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
                
                TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil,
                    success: {(operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
                        var user = User(dictionary: response as! NSDictionary)
                        
                        User.currentUser = user
                        
                        print("\(user.name!)")
                        self.loginCompletion?(user: user, error: nil)
                    }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                        print("error getting user")
                        self.loginCompletion!(user: nil, error: error)
                })
            }) {(error: NSError!) -> Void in
                print("Failed to receive acces token")
                self.loginCompletion!(user: nil, error: error)
        }
    }
}
