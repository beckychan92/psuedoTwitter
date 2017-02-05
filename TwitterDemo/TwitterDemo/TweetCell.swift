//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabe: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    var tweet: Tweet! {
        
        didSet {
            
            tweetTextLabel.text = tweet.text
            timestampLabel.text = String(describing: tweet.timestamp!)
            
//            retweetCountLabel.text = String(describing: tweet.retweetCount!)
//            favCountLabel.text = String(describing: tweet.favoritesCount!)
//            
//            tweetID = tweet.id!
//            if tweet.idStr != 0 {
//                originalTweetID = tweet.idStr
//                print("original tweet is : \(originalTweetID)")
//            }
//            
//            nameLabel.text = tweet.user?.name!
//            screenNameLabel.text = ("@" + (tweet.user?.screenname!)!)
//            
//            favStatus = tweet.favorited!
//            retweetStatus = tweet.retweeted!
//            
//            if let profileUrl = tweet.user?.profileUrl {
//                profileImage.setImageWith(profileUrl)
//            }
        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
