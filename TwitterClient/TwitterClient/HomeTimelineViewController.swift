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
        updateTimeline()
        
        self.tableView.estimatedRowHeight = 50
        self.tableView.rowHeight = UITableViewAutomaticDimension
        updateTimeline()
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showDetailSegue" { //attribute in the storyboard
            if let selectedIndex = self.tableView.indexPathForSelectedRow?.row { //selected row clicked on
                let selectedTweet = self.allTweets[selectedIndex]
                
                guard let destinationController = segue.destination as? TweetDetailViewController else { return }
                
                destinationController.tweet = selectedTweet
                }
        }
            
    }
    func updateTimeline(){
        self.activityIndicator.startAnimating()
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if let cell = cell as? TweetCell {
            cell.TweetText.text = allTweets[indexPath.row].text
        }
        
        return cell
    }
}

