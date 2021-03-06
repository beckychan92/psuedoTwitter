//
//  User.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileUrl: NSURL?
    var backgroundUrl: URL?
    var tagline: String?
    var followers: Int?
    var following: Int?
    var tweetCount: Int?
    
    
    var dictonary: NSDictionary?
    
    init(dictonary: NSDictionary) {
        self.dictonary = dictonary
        name = dictonary["name"] as? String
        screenname = dictonary["screen_name"] as? String
        
        if let profUrl = dictonary["profile_image_url_https"] as? String{
            profileUrl = NSURL(string: profUrl)
        }
        if let backgroundProf = dictonary["profile_background_image_url_https"] as? String{
            backgroundUrl = URL(string: backgroundProf)
        }
        
        tagline = dictonary["description"] as? String
        followers = dictonary["followers_count"] as? Int
        following = dictonary["friends_count"] as? Int
        tweetCount = dictonary["statuses_count"] as? Int

        print("User init set. User is \(name!)")
    }
    
    func getFollower() -> String{
        if let followers = self.followers{
            return String(describing: followers)
        }else{
            return "0"
        }
    }
    func getFollowing() -> String{
        if let following = self.following{
            return String(describing: following)
        }else{
            return "0"
        }
    }
    func getStatusCount() -> String{
        if let tweetCount = self.tweetCount{
            return String(describing: tweetCount)
        }else{
            return "0"
        }
    }
    

    
    static let userDidLogout = NSNotification.Name(rawValue: "UserDidLogout")
    
    static var _currentUser: User?
    
    class var currentUser: User?{
        get{

            if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
            
                if let userData = userData{
                    print("I found data cached")
                    if let dictionary = try? JSONSerialization.jsonObject(with: userData, options: .allowFragments){
                        print("I deserialized the data")
                        _currentUser = User(dictonary: dictionary as! NSDictionary)
                    }
                }
            }
            return _currentUser
            
        }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictonary!, options: [])

                defaults.set(data, forKey: "currentUserData")

            }else{
                defaults.set(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
            
        }
    }
}
