//
//  Tweeter.swift
//  TweetAlarm
//
//  Class handles posting tweets to Twitter, and stores the related API keys and tweets.
//  There is only one public method: tweet().
//
//  This class functions with the use of the Swifter framework, sttributed to github user mattdonnelly.
//
//  Created by Oliver James Richards on 09/08/2020.
//  Copyright © 2020 Oliver James Richards. All rights reserved.
//

import Foundation
import Social
import Swift
import SwifteriOS

class Tweeter {

    //api keys
   private struct APIKeys {
        static let key : String = "Pa4Zh0pXi2QlvmGDteDIO7gYp"
        static let secret : String = "a5USbgTHBIXojmVGhp1bNfrtXzp9PuVB1nuuLc8szOgTMxZYnw"
         }

    //user tokens
   private var token : String = "1293632180732780544-THwyE3pZ6pjTIgZghXiqFS53bsLswL"
   private var secret : String = "0oN9XeiKvjaqt4rP4V3vMT27hvUxJdTIaFwlwQAmGnpli"

    //account
    private let account : Swifter
    
    //tweets
    private var tweets = [String]()
    
    
    //Constructor creates the array of tweets and establishes the Twitter account within the Swifter framework.
    init() {
        //account
        account = Swifter(consumerKey: APIKeys.key, consumerSecret: APIKeys.secret, oauthToken: token, oauthTokenSecret: secret)
        
        //generate tweets
        tweets.append("The ownwer of this Twitter account snoozed their alarm this morning! tut-tut...")
        tweets.append("I'm a very lazy person. You'd be crazy to hire me...")
        tweets.append("Imagine employing me... smh, bad idea.")

    }
    
    //method has a 1/6 probability of posting a tweet to the associated twitter account, which is @SnoozeToTweet for the purposes of demonstration. 
    func tweet() {
        let diceRoll = 1
        if (diceRoll == 1) {
        let randomTweet = Int.random(in: 0..<tweets.count)
            account.postTweet(status: tweets[randomTweet])
        }
    }
}


