//
//  API.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/21/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import Foundation
import Accounts
import Social

typealias AccountCallback = (ACAccount?)->()
typealias TweetsCallback = ([Tweet]?)->()
typealias UserCallback = (User?)->()

class API {
    static let shared = API()
    
    var account : ACAccount?
    //get twitter account from device, using the Accounts Framework//escaping asychronist
    private func login(callback: @escaping AccountCallback) {
        let accountStore = ACAccountStore()//comes from accounts framework
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)//account instance of ACAccount store
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
            
            if let error = error { //unwrapping error// if error will store it here
                print("Error: \(error.localizedDescription).") //localize make app more dynamic for other language
                callback(nil)
                return
            }
            
            if success {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                    callback(account)//account is a local account from "if let account"
                    //if an array .first will access the first account
                }
            } else {
                print("The user did not allow access to their account.")
                callback(nil)
            }
        }
    }
    
    private func getOAuthUser(callback: @escaping UserCallback) {
        let url = URL(string: "https://api.twitter.com/1.1/accounts/verify_credentials.json")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: url, parameters: nil) {
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                if let error = error { //always use error before success
                    print("Error: \(error)")
                    callback(nil)
                    return //return used to escape the call back
                }
                
                guard let response = response else { callback(nil); return }
                guard let data = data else { callback(nil); return }
                
                switch response.statusCode {
                case 200...299:
                    JSONParser.authenticatedUser(data: data, callback: { (success, user) in
                        if success {
                            callback(user)
                        }
                    })
                case 400...499:
                    print("Client side error: \(response.statusCode)")
                case 500...599:
                    print("Server side error: \(response.statusCode)")
                default:
                    print("Error: Response came back with StatusCode: \(response.statusCode)")
                    callback(nil)
                }
            })
        }
    }
    
    private func updateTimeline(url: String, callback: @escaping TweetsCallback) {
        //let url = URL(string: " ")
        
        if let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: .GET, url: URL(string: url), parameters: nil) {
            request.account = self.account
            
            request.perform(handler: { (data, response, error) in
                if let error = error {
                    print("Error: Error requesting user's home timeline  \(error.localizedDescription)")
                    callback(nil)
                    return
                }
            
                
                guard let response = response else { callback(nil); return }
                guard let data = data else { callback(nil); return }
                
                switch response.statusCode {
                case 200...299:
                    JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
                        if success {
                            callback(tweets)
                        }
                    })
                case 300...399:
                    print("Client side error \(response.statusCode)")
                case 400...499:
                    print("Client side error \(response.statusCode)")
                case 500...599:
                    print("Server side error: \(response.statusCode)")
                default:
                    print("Error: Response came back with StatusCode: \(response.statusCode)")
                    callback(nil)
                }
            })
        }
    }
    
    func getTweets(callback: @escaping TweetsCallback) {
        if self.account == nil {
            
            login(callback: { (account) in
                if let account = account {
                    self.account = account
                    self.updateTimeline(url: "https://api.twitter.com/1.1/statuses/home_timeline.json", callback: { (tweets) in
                        print(tweets ?? "whatever")
                        callback(tweets)
                   
                    })
                }
            })
        } else {
            self.updateTimeline(url:"https://api.twitter.com/1.1/statuses/home_timeline.json", callback: {(tweets) in callback(tweets) // Essentially doing the same thing as above. How though? I'm confused.
        })
    }
  }
    
    func getTweetFor(_ user: String, callback: @escaping TweetsCallback){
        let urlString = "https://api.twitter.com/1.1/statuses/home_timeline.json?sscreen_name=\(user)"
        self.updateTimeline(url: urlString) {(tweets) in
            callback(tweets)
        }
    
    }
}
    
