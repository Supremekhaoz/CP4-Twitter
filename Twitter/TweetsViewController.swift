//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Luis Liz on 2/13/16.
//  Copyright © 2016 Luis Liz. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var tweets: [Tweet]?
    var retweets: [Retweet]?
    var favorites: [Favorite]?
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 120
        
        getTweets()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
    }
    
    override func viewDidAppear(animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        imageView.contentMode = .ScaleAspectFit
        
        let image = UIImage(named: "Twitter_logo_blue_32")
        imageView.image = image
        
        navigationItem.titleView = imageView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogout(sender: AnyObject) {
        User.currentUser?.logout()
    }
    
    func onRefresh() {
        getTweets()
        self.refreshControl.endRefreshing()
    }
    
    func getTweets() {
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]

        cell.tweetLabel.sizeToFit()
        
        return cell
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tweetControllerSegue" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPathForCell(cell) {
                
                let tweetController = segue.destinationViewController as! TweetViewController
                

                let selectedRow = (self.tableView.indexPathForSelectedRow?.row)! as NSInteger
                
                tweetController.tweets = tweets
                tweetController.index = selectedRow
                
                tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
        }
        
        if segue.identifier == "composeSegue" {
            let composeController = segue.destinationViewController as! ComposeViewController
            
            composeController.username = (User.currentUser?.name)!
            composeController.screenname = (User.currentUser?.screenname)!
            composeController.url = (User.currentUser?.name)!
            
        }
    }

}
