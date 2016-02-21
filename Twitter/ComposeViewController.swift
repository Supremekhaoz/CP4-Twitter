//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Luis Liz on 2/17/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate{
    var username: String?
    var screenname: String?
    var url: String?
    var tweets: [Tweet]?
    var row: Int?
    var tweetId: String = ""
    var isReply: Bool?
    var replyTo: String = "" 
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var chatCountLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var charCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self
        
        usernameLabel.text = (User.currentUser?.name)!
        handleLabel.text = (User.currentUser?.screenname)!
        textView.text = replyTo
        
        let imageUrl = (User.currentUser?.profileImageUrl)!
        profileImageView.setImageWithURL(NSURL(string: imageUrl)!)
        textView.becomeFirstResponder()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(textView: UITextView) {
        let count = textView.text.characters.count
        charCount.text = "\(140-count)"
        if (140-count) < 0 {
            charCount.textColor = UIColor.redColor()
        } else {
            charCount.textColor = UIColor.grayColor()
        }
    }
    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onTweet(sender: AnyObject) {
        if isReply == true {
            TwitterClient.sharedInstance.reply(tweetId, tweetText: "\(textView.text)")
        } else {
            TwitterClient.sharedInstance.tweet(textView.text)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
