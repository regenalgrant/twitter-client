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
        
        //setup labels
        
        print(self.tweet.user?.name ?? "Unknown")
        print(self.tweet.text)
  

    }



}
