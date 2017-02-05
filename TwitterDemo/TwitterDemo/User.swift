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
    var tagline: String?
    
    init(dictonary: NSDictionary) {
        name = dictonary["name"] as? String
        screenname = dictonary["screen_name"] as? String
        if let profUrl = dictonary["profile_image_url_https"] as? String{
            profileUrl = NSURL(string: profUrl)
        }
        tagline = dictonary["description"] as? String

    }
}
