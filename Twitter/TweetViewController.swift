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
    var tweetId: String!
    var user_id: String!
    var rtCount: Int?
    var favCount: Int?
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tweet = tweets![index!]
        
        rtCount = Int(tweet.retweetCount!)
        favCount = Int(tweet.favoriteCount!)
        
        usernameLabel.text = (tweet.user?.name)!
        handleLabel.text = "@\((tweet.user?.screenname)!)"
        tweetLabel.text = tweet.text
        retweetLabel.text = "\(rtCount!)"
        favoritesLabel.text = "\(favCount!)"
        
        user_id = tweet.user?.user_id
        tweetId = tweet.tweetId
        
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
        TwitterClient.sharedInstance.favorite(tweetId)
        favButton.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)
        
        favCount = favCount! + 1
        favoritesLabel.text = "\(favCount!)"
    }
    
    @IBAction func retweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweetId)
        retweetButton.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
        
        rtCount = rtCount! + 1
        retweetLabel.text = "\(rtCount!)"        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "replyTweetSegue" {
            print("started replying")
            let composeController = segue.destinationViewController as! ComposeViewController

            let tweet = tweets![index!]
            let replyHandle  = "@\((tweet.user?.screenname!)!) " as String
                
            composeController.tweetId = tweetId
            composeController.replyTo = replyHandle
            composeController.isReply = true
        }
        
        if segue.identifier == "profileSegue" {
            let profileController = segue.destinationViewController as! ProfileViewController
            
            let tweet = tweets![index!]
            let replyHandle  = "@\((tweet.user?.screenname!)!) " as String
            
            profileController.screenname = replyHandle
            profileController.tweets = tweets
            profileController.index = index
        }
    }
    

}
