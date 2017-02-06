//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UIScrollViewDelegate {
    var tweets: [Tweet]?
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
     var isMoreDataLoading = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Home Timeline"
        
        // Setting up tableview
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension

        refreshControl.addTarget(self, action: #selector(refreshControlAction(refreshControl:)), for: UIControlEvents.valueChanged)

        tableView.insertSubview(refreshControl, at: 0)
        
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: {(error: Error) -> () in
            print("Error in 'tweet viewDidLoad': \(error.localizedDescription)")
        })
    }


    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance.logout()
    }
    
    
    
    @IBAction func onRetweet(_ sender: Any) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets![indexPath!.row]
        
        
        if !(tweet.retweeted){
            TwitterClient.sharedInstance.retweet(id: tweet.id, success: {
                () in
                    print("repost!")
                    self.tweets![indexPath!.row].favoritesCount += 1
                    tweet.retweeted = true
                    cell.retweetButton.setImage(#imageLiteral(resourceName: "repost"), for: UIControlState())
                
            }, failure: { (error: Error) in
                print("Error in retweet 'tweet onRetweet': \(error.localizedDescription)")
            })
        }else{
            TwitterClient.sharedInstance.unretweet(id: tweet.id, success: {
                () in
                    print("unrepost!")
                    self.tweets![indexPath!.row].favoritesCount -= 1
                    tweet.retweeted = false
                    cell.retweetButton.setImage(#imageLiteral(resourceName: "notRepost"), for: UIControlState())
            }, failure: { (error: Error) in
                print("Error in unreet 'tweet onRetweet': \(error.localizedDescription)")
            })
        }
        self.tableView.reloadData()

    }
    
    @IBAction func onFavorite(_ sender: Any) {
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets![indexPath!.row]
        
        
        if !(tweet.favorited){
            TwitterClient.sharedInstance.favorite(params: ["id": tweet.id], success: {
                () in
                print("like!")
                self.tweets![indexPath!.row].favoritesCount += 1
                tweet.favorited = true
                cell.retweetButton.setImage(#imageLiteral(resourceName: "didlike"), for: UIControlState())
                
            }, failure: { (error: Error) in
                print("Error in like'tweet onFavorite': \(error.localizedDescription)")
            })
        }else{
            TwitterClient.sharedInstance.unfavorite(params: ["id": tweet.id], success: {
                () in
                print("unlike!")
                self.tweets![indexPath!.row].favoritesCount -= 1
                tweet.favorited = false
                cell.retweetButton.setImage(#imageLiteral(resourceName: "like"), for: UIControlState())
            }, failure: { (error: Error) in
                print("Error in unlike'tweet onFavorite': \(error.localizedDescription)")
            })
        }
        self.tableView.reloadData()
    }
    
    
    
    //Table code

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets?[indexPath.row]
        
        cell.tweet = tweet
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: {(error: Error) -> () in
            print("Error in 'tweet viewDidLoad': \(error.localizedDescription)")
        })
        refreshControl.endRefreshing()


    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                // ... Code to load more results ...
                TwitterClient.sharedInstance.homeTimeLine(success: { (tweets: [Tweet]) in
                    self.tweets = tweets
                    self.tableView.reloadData()
                }, failure: {(error: Error) -> () in
                    print("Error in 'tweet viewDidLoad': \(error.localizedDescription)")
                })
                
            }
        }
    }
    

}
