//
//  GitHubClient.swift
//  GithubUserSearch
//
//  Created by Julian Shen on 2015/5/8.
//  Copyright (c) 2015年 Julian Shen. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Alamofire

class GitHubClient {
    
    class func searchUser(keyword: String) -> SignalProducer<[User], NoError>  {
        return SignalProducer<[User], NoError> {
                observer, disposable in
                Alamofire.request(.GET, "https://api.github.com/search/users", parameters: ["q":keyword]).responseJSON { (_, _, JSON, error) in
                    if let jsonDict = JSON as? NSDictionary {
                        if let items: [NSDictionary] = jsonDict["items"] as? [NSDictionary] {
                            let users = items.map {
                                item -> User in
                                let user = User(user: item["login"] as! String, avatar: item["avatar_url"] as! String)
                                return user
                            }
                            sendNext(observer, users)
                        }
                    }
                    sendCompleted(observer)
                }
                return
        }
    }
    
}