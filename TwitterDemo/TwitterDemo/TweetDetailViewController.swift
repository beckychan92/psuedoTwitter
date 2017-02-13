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
        
        
        
    }


    @IBAction func onFavorite(_ sender: Any) {
        
    }
    

    @IBAction func onRetweet(_ sender: Any) {
        
    }

    @IBAction func onReply(_ sender: Any) {
        
    }

}
