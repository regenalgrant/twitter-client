//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/20/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource {
    
    var dataSource = [Tweet]()
    
    class TweetList {
        
        static let shared = TweetList()
        
        var allTweets = [Tweet]()
        
        private init(){}
        
        func addTweet(tweet: Tweet) {
            self.allTweets.append(tweet)
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
            
            if(success) {
                guard let tweets = tweets else { fatalError("Tweets came back nil.") }
                
                for tweet in tweets {
                    print(tweet.text)
                    TweetList.shared.addTweet(tweet: tweet)
                }
                dataSource = TweetList.shared.allTweets
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let tweet = dataSource[indexPath.row]
        
        cell.textLabel?.text = tweet.text
        cell.detailTextLabel?.text = tweet.user?.name
        
        return cell
    }
}

