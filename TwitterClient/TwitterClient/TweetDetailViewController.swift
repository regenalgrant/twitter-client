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
        print(self.tweet.user?.name ?? "Unknown User")
        print(self.tweet.text)
  

    }
    
    @IBOutlet weak var retweetText: UILabel!

}
