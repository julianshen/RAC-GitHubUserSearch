//
//  UserSearchViewModel.swift
//  GithubUserSearch
//
//  Created by Julian Shen on 2015/5/8.
//  Copyright (c) 2015年 Julian Shen. All rights reserved.
//

import Foundation
import ReactiveCocoa

class UserSearchViewModel: NSObject {
    private dynamic var searchKeyword: String?
    
    lazy var prop_keyword: DynamicProperty = DynamicProperty(object: self, keyPath: "searchKeyword")
    dynamic var users:[User]?
    
    lazy var prop_users: DynamicProperty = DynamicProperty(object: self, keyPath: "users")
    
}