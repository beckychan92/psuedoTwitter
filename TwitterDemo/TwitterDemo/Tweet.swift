//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var id: Int = 0
    var idStr: String?
    var text: String?
    var timestamp: Date?
    var timestampStr: String?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var favorited: Bool
    var retweeted: Bool
    
    init(dictionary: NSDictionary){
        user = User(dictonary: dictionary["user"]  as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        id = dictionary["id"] as! Int
        idStr = dictionary["id_str"] as? String
        if let timestampString = dictionary["created_at"] as? String{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
            timestampStr = formatter.string(from: timestamp!)
        }
        retweeted = dictionary["retweeted"] as! Bool
        favorited = dictionary["favorited"] as! Bool

    }
    
    class func tweetsWithArray(dictonaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dict in dictonaries{
            let tweet = Tweet(dictionary: dict)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
    class func tweetFromCurrentUser(tweet: Tweet) -> Bool{
        if let user = tweet.user{
            return user == User.currentUser
        }else{
            return false
        }
    }
    
    
}

