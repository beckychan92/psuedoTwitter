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


    @IBAction func onFavorite(_ sender: Any) {
        
    }
    

    @IBAction func onRetweet(_ sender: Any) {
        
    }

    @IBAction func onReply(_ sender: Any) {
        
    }

}
