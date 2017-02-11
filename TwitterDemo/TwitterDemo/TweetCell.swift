//
//  TweetCell.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabe: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    var tweet: Tweet! {
        
        didSet {
            
            tweetTextLabel.text = tweet.text
            timestampLabel.text = tweet.timestampStr!
            nameLabel.text = tweet.user?.name!
            screenNameLabe.text = "@\(tweet.user!.screenname!)"
            favoriteCountLabel.text = "\(tweet.favoritesCount)"
            retweetCountLabel.text = "\(tweet.retweetCount)"
            
            if let profileURL = tweet.user?.profileUrl{
                profileImage.setImageWith(profileURL as URL)
            }
            
            if (tweet.favoritesCount > 0){
                favoriteButton.setImage(UIImage(named: "didlike"), for: UIControlState())
            }else{
                favoriteButton.setImage(UIImage(named: "like"), for: UIControlState())
            }
            
            if (tweet.retweetCount > 0){
                retweetButton.setImage(UIImage(named: "repost"), for: UIControlState())
            }else{
                retweetButton.setImage(UIImage(named: "notRepost"), for: UIControlState())
            }

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
