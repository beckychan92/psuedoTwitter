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
    
    @IBAction func onLoginButton(_ sender: Any) {
        TwitterClient.sharedInstance.login(success: { () -> () in
            print("I've logged in")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: { (error: Error) -> () in
            print("Error in 'onLoginbButton': \(error.localizedDescription)")
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
