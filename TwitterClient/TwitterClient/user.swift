//
//  user.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/20/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import Foundation


class User  {

    let   name : String 
    let profileImageUrl : String
    let location : String
    
    init?(json: String [String: Any])  {
        if let name = json[" name" ] as? String,
            let profileImageUrl = json["profile_image_Url"] {
            location = json [location] as? String{
                
                self.name = name
                self.location = name
            } else {
                return nil
            }
        
    }
    
    
}
