//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    init(dictionary: NSDictionary){
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorites_count"] as? Int) ?? 0
        if let timestampString = dictionary["created_at"] as? String{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }

    }
    
    class func tweetsWithArray(dictonaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictonary in dictonaries{
            let tweet = Tweet(dictionary: dictonary)
            tweets.append(tweet)
        }
        
        return tweets
    }
    
    
}

