//
//  TweetViewController.swift
//  Twitter
//
//  Created by Luis Liz on 2/17/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    var tweets: [Tweet]?
    var index: Int?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tweet = tweets![index!]
        
        usernameLabel.text = (tweet.user?.name)!
        handleLabel.text = "@\((tweet.user?.screenname)!)"
        tweetLabel.text = tweet.text
        retweetLabel.text = tweet.retweetCount
        favoritesLabel.text = tweet.favoriteCount
        
        let imageUrl = tweet.user?.profileImageUrl!
        avatarView.setImageWithURL(NSURL(string: imageUrl!)!)
        
        let imageView = avatarView
        imageView.userInteractionEnabled = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func favorite(sender: AnyObject) {
        print("another fav")
    }
    
    @IBAction func retweet(sender: AnyObject) {
        print("another rt")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
