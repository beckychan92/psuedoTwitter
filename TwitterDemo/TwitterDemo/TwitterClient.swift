//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    
    var consumerKey: String!
    var consumerSecret: String!
    
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: ValueFromPlist().consumerKey, consumerSecret: ValueFromPlist().consumerSecret)
    
    func homeTimeLine(success: @escaping (([Tweet]) -> ()), failure: @escaping (Error) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {
            (task: URLSessionDataTask, response: Any?) -> Void in
            let dictonaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictonaries: dictonaries)
//            for tweet in tweets{
//                print("tweet: \(tweet.text!)")
//            }
            success(tweets)
            
        }, failure: {
            (task: URLSessionDataTask?, error: Error) -> Void in
            failure(error)
        })
    }
    
    func currentAccount(){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {
            (task: URLSessionDataTask, response: Any?) -> Void in
            let userDict = response as! NSDictionary
            let user = User(dictonary: userDict)
            print(user.screenname!)
            
        }, failure: {
            (task: URLSessionDataTask?, error: Error) -> Void in
        })
    }
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance?.deauthorize()
        
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth")!, scope: nil, success: { (requestToken:BDBOAuth1Credential?) -> Void in
            print("I got a token: \(requestToken!.token!)")
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)")!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }, failure: { (error: Error?) -> Void in
            print(" error: \(error?.localizedDescription)")
            self.loginFailure!(error!)
        })
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken,
                                success: { (accessToken: BDBOAuth1Credential?) -> Void in
                                        self.loginSuccess?()
//                                    client.homeTimeLine(success: { (tweets:[Tweet]) in
//                                        for tweet in tweets{
//                                            print(tweet.text)
//                                        }
//                                    }, failure: { (error: Error) in
//                                        print(error.localizedDescription)
//                                    })
                                }, failure: { (error: Error?) -> Void in
                                    self.loginFailure?(error!)
                                })
    }
    

}
