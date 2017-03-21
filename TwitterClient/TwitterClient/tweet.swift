//
//  tweet.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/20/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import Foundation

class Tweet {
    
        let text : String
        let id: String
    
//(?)optional//
        var user : User?

    //dictionary of json /String can be Keys from dictionary//
        init? (json:[String: Any])  {
            if let text = json ["text"] as? String, let id = json ["id_str"] as? String  {
                self.text = text
                self.id = id
                if let userDictionary = json [ "user" ] as? [String : Any ] {
                self.user = User(json: userDictionary)
                }
            } else {
                return nil
            }
                
        }
}
