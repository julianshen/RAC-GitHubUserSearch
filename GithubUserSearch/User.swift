//
//  User.swift
//  GithubUserSearch
//
//  Created by Julian Shen on 2015/5/8.
//  Copyright (c) 2015年 Julian Shen. All rights reserved.
//

import Foundation

class User {
    let login:String
    let avatar_url:String
    
    init(user: String, avatar: String) {
        login = user
        avatar_url = avatar
    }
}