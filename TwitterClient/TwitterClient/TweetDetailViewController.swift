//
//  TweetDetailViewController.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/22/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var tweet : Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        retweetText.text = self.tweet.text
        retweetedLabel.text = "Retweet count is: \(self.tweet.retweetCount)"
        print(self.tweet.user?.name ?? "Unknown User")
        print(self.tweet.text)
        if let user = tweet.user {
            
            UIImage.fetchImageWith(user.profileImageUrl){ (image) in
                self.userImageView.image = image
            }
        }
  

    }
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var retweetText: UILabel!
    @IBOutlet weak var retweetedLabel: UILabel!
}
