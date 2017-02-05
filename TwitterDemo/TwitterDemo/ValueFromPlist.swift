//
//  ValueFromPlist.swift
//  TwitterDemo
//
//  Created by Rob Hernandez on 2/4/17.
//  Copyright © 2017 Robert Hernandez. All rights reserved.
//

import UIKit

class ValueFromPlist: NSObject {
    var consumerKey = ""
    var consumerSecret = ""
    
    override init(){
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
    
//    class func getConsumeKey() -> String {
//        let VFP = ValueFromPlist()
//        return VFP.consumerKey
//    }
//    
//    class func getConsumeSecret() -> String {
//        let VFP = ValueFromPlist()
//        return VFP.consumerSecret
//    }

}
