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
            timestampLabel.text = tweet.timestampStr!
            nameLabel.text = tweet.user?.name!
            screenNameLabe.text = "@\(tweet.user!.screenname!)"
            
            if let profileURL = tweet.user?.profileUrl{
                profileImage.setImageWith(profileURL as URL)
            }
            
//            retweetCountLabel.text = String(describing: tweet.retweetCount!)
//            favCountLabel.text = String(describing: tweet.favoritesCount!)
//            
//            tweetID = tweet.id!
//            if tweet.idStr != 0 {
//                originalTweetID = tweet.idStr
//                print("original tweet is : \(originalTweetID)")
//            }
//             
//            favStatus = tweet.favorited!
//            retweetStatus = tweet.retweeted!
//            

        }
    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
