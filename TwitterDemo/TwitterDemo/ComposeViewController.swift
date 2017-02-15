//
//  ComposeViewController.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/13/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    // Constants
    let TEXT_LIMIT = 141
    let DEFAULT_MSG = "What's on your mind?"
    let GRAY = UIColor.lightGray
    let RED = UIColor.red
    
    // instance vars
    var can_send = false
    var tweet: Tweet!

    @IBOutlet weak var charCount: UIBarButtonItem!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var textSection: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Setup the text box
        textSection.delegate = self
        textSection.text! = DEFAULT_MSG
        // Set the count Label
        charCount.title = "\(TEXT_LIMIT - DEFAULT_MSG.characters.count)"
        charCount.tintColor = GRAY
        
        // set the reply headers
        screenNameLabel.text = tweet.user?.screenname
        nameLabel.text = tweet.user?.screenname
        profileImg.setImageWith((tweet.user?.profileUrl)! as URL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(_ sender: Any) {
        if can_send{
            
        }
    }

    
    func textViewDidChange(_ textView: UITextView) {
        if  (TEXT_LIMIT - textSection.text!.characters.count) > 0 {
            charCount.tintColor = GRAY
            charCount.title = "\(TEXT_LIMIT - textSection.text!.characters.count)"
            self.can_send = true
        }
        else{
            charCount.tintColor = RED
            charCount.title = "\(TEXT_LIMIT - textSection.text!.characters.count)"
            self.can_send = false
        }
    }
    

}
