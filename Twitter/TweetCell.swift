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
    
    var tweet: Tweet! {
        didSet {
            usernameLabel.text = (tweet.user?.name)!
            tweetLabel.text = tweet.text
            handleLabel.text = "@\((tweet.user?.screenname)!)"
            timestampLabel.text = "\(tweet.createdAt!)"
            
            let imageUrl = tweet.user?.profileImageUrl!
            profileImageView.setImageWithURL(NSURL(string: imageUrl!)!)
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
