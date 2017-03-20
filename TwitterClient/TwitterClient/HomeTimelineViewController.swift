//
//  HomeTimelineViewController.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/20/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        
        JSONParser.tweetsFrom(data: JSONParser.sampleJSONData) { (success, tweets) in
            if (success){
                guard let tweets = tweets else {fatalError("Tweets came back nil")}
                
                for tweet in tweets {
                    print(tweet.text)
                }
            }
        }

    }
    //you will never call these function built- in//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell ", for: indexPath)
        
        cell.textLabel?.text = "Indexpath: |(indexPath.row)"
        
        return cell
    }

}

