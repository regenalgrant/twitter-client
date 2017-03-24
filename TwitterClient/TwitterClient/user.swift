//
//  user.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/20/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import Foundation


class User  {
    var name: String
    var profileImageUrl: String
    var location: String
    var screenName : String
    
    init?(json:[String: Any]) {
        // print (json)
        
        if let name = json[" name" ] as? String,
            let profileImageUrl = json["profile_image_url_https"] as? String,
            let location = json ["location"] as? String,
            let screenName = json["screen_name"] as? String {
                
            self.name = name
            self.profileImageUrl = profileImageUrl
            self.location = location
            self.screenName = screenName
        
        } else {
            return nil
        }
        
        }
    
    }
