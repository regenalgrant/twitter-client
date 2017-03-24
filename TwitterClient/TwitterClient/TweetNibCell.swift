//
//  TweeetNibCell.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/23/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class TweetNibCell: UITableViewCell {

    @IBOutlet weak var useerImageView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
   
    var tweet: Tweet! {
        didSet {
self.tweetLabel.text = tweet.text
self.usernameLabel.text = tweet.user?.name ?? "Unknown User"
            if let user = tweet.user {
            
            UIImage.fetchImageWith(user.profileImageUrl){ (image) in
                self.useerImageView.image = image
            }
        }
    }

}
}
