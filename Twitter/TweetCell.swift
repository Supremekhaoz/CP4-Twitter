//
//  TweetCell.swift
//  Twitter
//
//  Created by Luis Liz on 2/14/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var profileImageButton: UIButton!
    
    var tweet_id: String!
    var rtCount: Int?
    var favCount: Int?
    
    var tweet: Tweet! {
        didSet {
            rtCount = Int(tweet.retweetCount!)
            favCount = Int(tweet.favoriteCount!)

            usernameLabel.text = (tweet.user?.name)!
            tweetLabel.text = tweet.text
            handleLabel.text = "@\((tweet.user?.screenname)!)"
            timestampLabel.text = "\(tweet.createdAt!)"
            retweetLabel.text = "\(rtCount!)"
            favoriteLabel.text = "\(favCount!)"
            
            let imageUrl = tweet.user?.profileImageUrl!
            profileImageView.setImageWithURL(NSURL(string: imageUrl!)!)
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.userInteractionEnabled = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onProfileImage(sender: AnyObject) {
        
    }
    
    @IBAction func retweet(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet_id)
        //retweetButton.setImage(UIImage(named: "retweet-action-on-green"), forState: UIControlState.Normal)
        
        rtCount = rtCount! + 1
        retweetLabel.text = "\(rtCount!)"
    }
    
    @IBAction func favorite(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet_id)
        //favButton.setImage(UIImage(named: "like-action-on-red"), forState: UIControlState.Normal)

        favCount = favCount! + 1
        favoriteLabel.text = "\(favCount!)"

    }
    
}
