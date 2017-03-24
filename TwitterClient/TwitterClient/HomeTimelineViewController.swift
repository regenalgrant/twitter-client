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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var numberOFTweets: UILabel!
    
    var allTweets = [Tweet]() {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
    super.viewDidLoad() //override parents version but continue to do the function //
        
        self.navigationItem.title = "Time Line" //Title on the UI//
        self.tableView.dataSource = self //dataSource will pull in tableView //
        self.tableView.delegate = self
//        API.shared.getTweets { (fetchTweets) in
//            if let fetchTweets = fetchTweets {
//                self.allTweets = fetchTweets 
//                
//            }
//        }
//        
        updateTimeline()
        let tweetNib = UINib(nibName: "TweetNibCell", bundle: nil)

        self.tableView.register(tweetNib, forCellReuseIdentifier: TweetNibCell.identifier)
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension

    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == TweetDetailViewController.identifier { //attribute in the storyboard
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row { //selected row clicked on
            let selectedTweet = self.allTweets[selectedIndex]
                
                if let destinationViewController = segue.destination as? TweetDetailViewController {
                destinationViewController.tweet = selectedTweet
        }
            }
        }
    }
    func updateTimeline(){
        self.activityIndicator.startAnimating()
        print("update tieleine")
        API.shared.getTweets {(tweets)in
            OperationQueue.main.addOperation {
            self.allTweets = tweets ?? []
                self.activityIndicator.stopAnimating()//stop after network request
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetNibCell.identifier , for: indexPath) as! TweetNibCell
        
        let tweet = self.allTweets[indexPath.row]
        cell.tweet = tweet
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row click")
        self.performSegue(withIdentifier: TweetDetailViewController.identifier, sender: self)
    }
 
    
    
}


