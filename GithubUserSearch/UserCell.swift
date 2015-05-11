//
//  UserCell.swift
//  GithubUserSearch
//
//  Created by Julian Shen on 2015/5/7.
//  Copyright (c) 2015年 Julian Shen. All rights reserved.
//

import UIKit
import ReactiveCocoa

class UserCell:UITableViewCell {
    @IBOutlet weak var avatarImageView:UIImageView!
    @IBOutlet weak var userNameLabel:UILabel!
    
    var imageLoading: Disposable?
}
