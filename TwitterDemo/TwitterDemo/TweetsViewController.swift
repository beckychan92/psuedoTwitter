//
//  TweetsViewController.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
    var tweets: [Tweet]!

    override func viewDidLoad() {

        super.viewDidLoad()


        // Do any additional setup after loading the view.
        TwitterClient.sharedInstance!.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
        }, failure: {(error: Error) -> () in
            print(error.localizedDescription)
        })
    }


    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
