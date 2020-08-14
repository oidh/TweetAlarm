//
//  Tweeter.swift
//  TweetAlarm
//
//  Created by Oliver James Richards on 09/08/2020.
//  Copyright © 2020 Oliver James Richards. All rights reserved.
//

import Foundation
import Social
import Swift
import SwifteriOS


class Tweeter {

    init() {
        
        self.key = "Pa4Zh0pXi2QlvmGDteDIO7gYp"
        self.secretKey = "a5USbgTHBIXojmVGhp1bNfrtXzp9PuVB1nuuLc8szOgTMxZYnw"
        self.BearerToken = "AAAAAAAAAAAAAAAAAAAAAIsuGwEAAAAANixwXQUROrryJ0y5zEiJB%2BQKZNE%3Ds8tD3zhMZQtzP9iUsL70TGStfSDPjd8qcCDGim7Q6YC4MwCnxQ"
        
        self.devAccount = Swifter(consumerKey: key, consumerSecret: secretKey)
        
    }
    
    //api tokens
    private let key : String
    private let secretKey : String
    private let BearerToken : String
    
    //account
    let devAccount : Swifter
    
    func thisisatest() {
        
        devAccount.postTweet(status: "i made it, hans!")
        
        
    }
    
    
    
    
}


