//
//  API.swift
//  TwitterClient
//
//  Created by Regenal Grant on 3/21/17.
//  Copyright © 2017 Regenal Grant. All rights reserved.
//

import Foundation
import Accounts

typealias AccountCallback = (ACAccount?) -> ()
typealias UserCallback = (User?) -> ()
typealias TweetsCallback = ([Tweet]) -> ()


class API {
    static let shared = API() //a singleton global instance of API//

    var account : ACAccount?

    private func  login(callback: @escaping AccountCallback){ //tweeter will be given//can escape this
        let accountStore = ACAccountStore()
        
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil){(Bool, error)
            in
            
            if let error = error {
                print("Error: \(error.localizedDescription)" )
                callback(nil)
                return
            }
            
            if success {
                if let account = accountStore.accounts(with: accountType).first as? ACAccount {
                }
            } else {
                print("The user did not allow access to thier account")
                callback(success)
            }
        }
    }
    private func getOAuthUser (userback: UserCallback){
        
        
    }
    private func updateTimeLine(callback: TweetsCallback){
        
    }
    func getTweets(callback: TweetsCallback){

    }
}
