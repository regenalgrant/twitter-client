//
//  user.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/20/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import Foundation


class User  {
    let name: String
    let profileImageUrl: String
    let location: String
    
    init?(json:[String: Any]){
        if let name = json[" name" ] as? String,
            let profileImageUrl = json["profile_image_url"] as? String ,
            let location = json ["location"] as? String {
            self.name = name
            self.profileImageUrl = profileImageUrl
            self.location = location
            
        }
        else{
            return nil
        }
        
    }
    
}
