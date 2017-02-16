//
//  ProfileViewController.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/14/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var tweet: Tweet?
    var user: User!
    
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
        if let tweet = tweet{
            user = tweet.user
        }
        
        profileImg.setImageWith((user.profileUrl)! as URL)
        nameLabel.text = user.name
        screenNameLabel.text = user.screenname
        backgroundImg.setImageWith((user.backgroundUrl)!)
        followerCountLabel.text = user.getFollower()
        followingCountLabel.text = user.getFollowing()
        tweetCountLabel.text = user.getStatusCount()
        backgroundImg.sizeToFit()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
