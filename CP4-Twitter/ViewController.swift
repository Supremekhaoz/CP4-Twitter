//
//  ViewController.swift
//  CP4-Twitter
//
//  Created by Luis Liz on 2/8/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: {(requestToken:BDBOAuth1Credential!) -> Void in
                print("Got the request")
            }) {(failure: NSError!) -> Void in
                print("Failed to get request token")
        }
    }

}

