//
//  JSONParser.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/20/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import Foundation

typealias JSONParserCallback = (Bool, [Tweet]?)->()
// Type alias means we can give a name to another type (e.g. typealias JSONParserCallBack = ()->). The Bool is used as a "success" flag.
typealias UserAuthenticated = (Bool, User?)->()

class JSONParser {
    
    static var sampleJSONData : Data {
        guard let tweetJSONPath = Bundle.main.url(forResource: "tweet", withExtension: "json") else { fatalError("Tweet.json does not exist in this bundle.") }
        
        do {
            let tweetJSONData = try Data(contentsOf: tweetJSONPath)
            
            return tweetJSONData
            
        } catch {
            fatalError("Failed to create data from tweetJSONPath.")
        }
    }
    
    class func authenticatedUser(data: Data, callback: UserAuthenticated) {
        
        do {
            if let userJSON = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any] {
                let user = User(json: userJSON)
                callback(true, user)
            }
        } catch {
            print("Error serializing JSON.")
            callback(false, nil)
//We are executing the above callback with a false flag and nil as the array of tweets.//
        }
    }
    
    class func tweetsFrom(data: Data, callback: JSONParserCallback) {
// Will read in Data and convert it into our native Swift language, so it knows it's dictionaries and arrays.//
        
        do {
            // rootObject is common terminology for the whole JSON file.
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String : Any]] {
                var tweets = [Tweet]()
                
                for tweetDictionary in rootObject {
                    if let tweet = Tweet(json: tweetDictionary) {
                        tweets.append(tweet)
                    }
                }
                
                callback(true, tweets)
            }
        } catch {
            print("Error serializing JSON.")
            callback(false, nil)
// We are executing the above callback with a false flag and nil as the array of tweets.//
        }
    }
}
