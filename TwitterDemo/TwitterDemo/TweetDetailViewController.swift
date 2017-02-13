//
//  TweetDetailViewController.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/12/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    var tweet: Tweet!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // Set the name
        self.navigationItem.title = "Tweet"

        
        // Setup the View
        tweetTextLabel.text = tweet.text!
        timestampLabel.text = tweet.timestampStr!
        nameLabel.text = tweet.user?.name!
        screenameLabel.text = "@\(tweet.user!.screenname!)"
        favoriteCountLabel.text = "\(tweet.favoritesCount)"
        retweetCountLabel.text = "\(tweet.retweetCount)"
        
        if let profileURL = tweet.user?.profileUrl{
            profileImg.setImageWith(profileURL as URL)
        }
        
        if (tweet.favorited){
            favoriteButton.setImage(UIImage(named: "didlike"), for: UIControlState())
        }else{
            favoriteButton.setImage(UIImage(named: "like"), for: UIControlState())
        }
        
        if (tweet.retweeted){
            retweetButton.setImage(UIImage(named: "repost"), for: UIControlState())
        }else{
            retweetButton.setImage(UIImage(named: "notRepost"), for: UIControlState())
        }
        
    }
    
    func handleCount(str: String, increment: Bool) -> String{
        let incrementor = increment ? 1 : -1
        if let count = Int(str){
            if count > 0{
                return "\(count + incrementor)"
            }else{
                return "0"
            }
        }else{
            return "0"
        }
    }


    @IBAction func onFavorite(_ sender: Any) {
        if !(tweet.favorited){
            TwitterClient.sharedInstance.favorite(params: ["id": tweet.id], success: {
                () in
                print("like in detail controller!")
                self.favoriteCountLabel.text = self.handleCount(str: self.favoriteCountLabel.text!, increment: true)
                self.tweet.favorited = true
                self.favoriteButton.setImage(#imageLiteral(resourceName: "didlike"), for: UIControlState())
                
            }, failure: { (error: Error) in
                print("Error in like'tweet onFavorite': \(error.localizedDescription)")
            })
        }else{
            TwitterClient.sharedInstance.unfavorite(params: ["id": tweet.id], success: {
                () in
                print("unlike in detail controller!")
                self.favoriteCountLabel.text =  self.handleCount(str: self.favoriteCountLabel.text!, increment: false)
                self.tweet.favorited = false
                self.favoriteButton.setImage(#imageLiteral(resourceName: "like"), for: UIControlState())
            }, failure: { (error: Error) in
                print("Error in unlike'tweet onFavorite': \(error.localizedDescription)")
            })
        }
    }
    

    @IBAction func onRetweet(_ sender: Any) {
        if !(tweet.retweeted){
            TwitterClient.sharedInstance.retweet(id: tweet.id, success: {
                () in
                print("repost!")
                self.retweetCountLabel.text =  self.handleCount(str: self.retweetCountLabel.text!, increment: true)
                self.tweet.retweeted = true
                self.retweetButton.setImage(#imageLiteral(resourceName: "repost"), for: UIControlState())
                
            }, failure: { (error: Error) in
                print("Error in retweet 'tweet onRetweet': \(error.localizedDescription)")
            })
        }else{
            TwitterClient.sharedInstance.unretweet(id: tweet.id, success: {
                () in
                print("unrepost!")
                self.retweetCountLabel.text =  self.handleCount(str: self.retweetCountLabel.text!, increment: false)
                self.tweet.retweeted = false
                self.retweetButton.setImage(#imageLiteral(resourceName: "notRepost"), for: UIControlState())
            }, failure: { (error: Error) in
                print("Error in unreet 'tweet onRetweet': \(error.localizedDescription)")
            })
        }

    }

    @IBAction func onReply(_ sender: Any) {
        
    }

}
