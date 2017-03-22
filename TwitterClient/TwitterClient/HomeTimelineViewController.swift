//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/20/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit
import Foundation

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    
    var allTweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
    super.viewDidLoad() //override parents version but continue to do the function //
        
        self.tableView.dataSource = self //dataSource will pull in tableView //
        updateTimeline()
    
    }
    
    func updateTimeline(){
        API.shared.getTweets {(tweets)in
            OperationQueue.main.addOperation {
            self.allTweets = tweets ?? []
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let tweet = allTweets[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        
        return cell
    }
}

