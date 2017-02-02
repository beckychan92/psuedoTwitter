//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 1/30/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com") as URL! , consumerKey: "C4vPLswb4dJln1tD464EVeJbl", consumerSecret: "7Vc7tw6XDR9T44H4RIwGWLr7KLUMMlSpJHW3ER9OjSoA4NOvgA")
        //twitterClient?.fetchRequestToken(withPath: <#T##String!#>, method: <#T##String!#>, callbackURL: <#T##URL!#>, scope: <#T##String!#>, success: <#T##((BDBOAuth1Credential?) -> Void)!##((BDBOAuth1Credential?) -> Void)!##(BDBOAuth1Credential?) -> Void#>, failure: <#T##((Error?) -> Void)!##((Error?) -> Void)!##(Error?) -> Void#>)
        
        
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
