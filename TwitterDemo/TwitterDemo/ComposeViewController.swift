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
    var can_send = true
    var tweet: Tweet?
    var user: User!

    @IBOutlet weak var charCount: UIBarButtonItem!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var textSection: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let tweet = tweet{
            user = tweet.user
        }
        
        
        // Setup the text box
        textSection.delegate = self
        textSection.text! = DEFAULT_MSG
        // Set the count Label
        charCount.title = "\(TEXT_LIMIT - DEFAULT_MSG.characters.count)"
        charCount.tintColor = GRAY
        
        // set the reply headers
        screenNameLabel.text = user.screenname
        nameLabel.text = user.screenname
        profileImg.setImageWith((user.profileUrl)! as URL)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTweet(_ sender: Any) {
        let msg = textSection.text!
//        let escapedMsg = msg.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        if can_send{
            if(user == User.currentUser){
                
                TwitterClient.sharedInstance.compose(params: ["status": msg], success: {
                    () in
                    print("message compose sent!")
                }, failure: { (error: Error) in
                    print("Error in composeView 'compose onTweet': \(error.localizedDescription)")

                })

            }else{
                
                TwitterClient.sharedInstance.reply(params: ["status": msg, "in_reply_to_status_id": tweet!.id ], success: {
                    () in
                    print("message reply sent!")
                }, failure: { (error: Error) in
                    print("Error in composeView 'reply onTweet': \(error.localizedDescription)")
                })
            }
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
