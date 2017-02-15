//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/14/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var tweet: Tweet!
    
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var followerCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        profileImg.setImageWith((tweet.user?.profileUrl)! as URL)
        nameLabel.text = tweet.user?.name
        screenNameLabel.text = tweet.user?.screenname
        backgroundImg.setImageWith((tweet.user?.backgroundUrl)!)
        followerCountLabel.text = "\(tweet.user?.followers)"
        followingCountLabel.text = "\(tweet.user?.following)"
        tweetCountLabel.text = "\(tweet.user?.tweetCount)"
        backgroundImg.sizeToFit()
        profileImg.sizeToFit()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
