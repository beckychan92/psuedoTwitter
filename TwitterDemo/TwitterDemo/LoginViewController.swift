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
    var consumerKey: String!
    var consumerSecret: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        setKeysFromPlist()
       
        // Do any additional setup after loading the view.
    }

    func setKeysFromPlist(){
        var keys: NSDictionary?
        
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
            keys = NSDictionary(contentsOfFile: path)
        }else{
            print("found no bundle")
        }
        
        if let dict = keys {
            self.consumerKey = dict["consumerKey"] as! String
            self.consumerSecret = dict["consumerSecret"] as! String
            print("keys set viewcontroller")
        }else{
            print("found no key")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: self.consumerKey, consumerSecret: self.consumerSecret)
        twitterClient?.deauthorize()
        
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth")!, scope: nil, success: { (requestToken:BDBOAuth1Credential?) -> Void in
            print("I got a token: \(requestToken!.token!)")
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }, failure: { (error: Error?) -> Void in
            print(" error: \(error?.localizedDescription)")
        })
        
        
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
