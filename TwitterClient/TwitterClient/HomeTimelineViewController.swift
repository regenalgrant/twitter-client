//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/20/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var dataSource = [Tweet]() // to init dataSource of an array //
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad() //override parents version but continue to do the function //
        
        self.tableView.dataSource = self //dataSource will pull in tableView //
        self.tableView.delegate = self // delegate is  protocol //
        
        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
            if(success) {
                guard let tweets = tweets else { fatalError( "Tweets came back nil." ) }
                
                for tweet in tweets {
                    print(tweet.text)
                    Tweet.shared.add(tweet: tweet)
                }
                dataSource = Tweet.shared.allTweets
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
        cell.detailTextLabel?.text = tweet.user?.name // (tweet.user|?|.name) says that name with will not print out //
        
        return cell
    }
}

