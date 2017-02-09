//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
let twitterConsumerKey = ValueFromPlist().consumerKey
let twitterConsumerSecret = ValueFromPlist().consumerSecret


class TwitterClient: BDBOAuth1SessionManager {
    
    static var sharedInstance: TwitterClient {
        struct Static {
            static let instance  = TwitterClient(
                baseURL: URL(string: "https://api.twitter.com")!,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance!
    }
    
    //static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: ValueFromPlist().consumerKey, consumerSecret: ValueFromPlist().consumerSecret)!
    
    
    // HomeTimeline API
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: {
            (task: URLSessionDataTask, response: Any) -> Void in
                let dict = response as! [NSDictionary]
                print("homeTimeline success")
                let tweets = Tweet.tweetsWithArray(dictonaries: dict)
                success(tweets)
        
        }, failure: {
            (task: URLSessionDataTask?, error: Error) -> Void in
                print("failed hometimeline")
                failure(error)
        })
    }
    
    // Current Account API
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: {
            (task: URLSessionDataTask, response: Any?) -> Void in
                let userDict = response as? NSDictionary
                print("currentAccount success")
                let user = User(dictonary: userDict!)
                success(user)
        }, failure: {
            (task: URLSessionDataTask?, error: Error) -> Void in
                print("failed current accrount")
                failure(error)
        })
    }
    
    //favorite API
    func favorite(params: NSDictionary?, success: @escaping () -> (), failure: @escaping (Error) -> ()){
        post("1.1/favorites/create.json", parameters: params, progress: nil, success: { (operation: URLSessionDataTask, response: Any) -> Void in
                print("succesful favorite")
                success()
        }, failure: { (operation: URLSessionDataTask?, error: Error?) -> Void in
            print("Couldn't favorite tweet")
            failure(error!)
        }
        )
    }
    
    func unfavorite(params: NSDictionary?,  success: @escaping () -> (), failure: @escaping (Error) -> () ){
        post("1.1/favorites/destroy.json", parameters: params, progress: nil, success: { (operation: URLSessionDataTask!, response: Any?) -> Void in
                print("succesful unfavorite")
                success()
        }, failure: { (operation: URLSessionDataTask?, error: Error?) -> Void in
            print("Couldn't favorite tweet")
            failure(error!)
        }
        )
    }
    
    //retweet API
    
    func retweet(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> () ){
        post("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (operation: URLSessionDataTask!, response: Any?) -> Void in
                print("succesful retweet")
                success()
        }, failure: { (operation: URLSessionDataTask?, error: Error!) -> Void in
            print("Couldn't retweet")
            failure(error!)
        }
        )
        
        
    }
    
    func unretweet(id: Int, success: @escaping () -> (), failure: @escaping (Error) -> () ){
        post("1.1/statuses/unretweet/\(id).json", parameters: nil, progress: nil, success: { (operation: URLSessionDataTask!, response: Any?) -> Void in
                print("succesful unretweet")
                success()
        }, failure: { (operation: URLSessionDataTask?, error: Error?) -> Void in
            print("Couldn't unretweet")
            failure(error!)
        }
        )
    }
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    
    //Login Api
    func login(success: @escaping () -> (), failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance.deauthorize()
        
        fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterdemo://oauth")!, scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
                print("I got a token, so logining in: \(requestToken!.token!)")
            if let url =  URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken!.token!)"){
                print("login success")
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }else{
                print("token has expired")
            }
        }, failure: { (error: Error?) -> Void in
                print(" error in login: \(error?.localizedDescription)")
                self.loginFailure?(error!)
        })
    }
    
    // Logout API
    func logout(){
        print("logging out")
        deauthorize()
        User.currentUser = nil
        NotificationCenter.default.post(name: User.userDidLogout, object: nil)
    }
    
    
    //Handle Open URL API
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) -> Void in
                print("fetch access token in handle openURL success")
                self.currentAccount(success: { (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: Error) in
                    self.loginFailure?(error)
                })
            
            }, failure: { (error: Error?) -> Void in
                print("fetch access failed")
                self.loginFailure?(error!)
            })
    }
    

}
