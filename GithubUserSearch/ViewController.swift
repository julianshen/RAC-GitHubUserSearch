//
//  ViewController.swift
//  GithubUserSearch
//
//  Created by Julian Shen on 2015/5/7.
//  Copyright (c) 2015年 Julian Shen. All rights reserved.
//

import UIKit
import ReactiveCocoa
import WebImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static let REUSE_ID = "user_cell"
    let viewModel: UserSearchViewModel = UserSearchViewModel()
    lazy var defaultProfileImage = UIImage(named: "smiley")
    
    @IBOutlet weak var keywordInput: UITextField!
    @IBOutlet weak var userListView: UITableView!
    lazy var loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.prop_keyword <~ keywordInput.rac_textSignal().toSignalProducer() |> catch {
            _ in
            return SignalProducer<AnyObject?, NoError>(value:"")
        }
        
        let filteredKeywordSignalProducer = viewModel.prop_keyword.producer
        |> filter {
            return count($0 as! String) >= 3
        }
        
        let throttledKeywordSignalProducer = filteredKeywordSignalProducer |> throttle(0.5, onScheduler: QueueScheduler())
        throttledKeywordSignalProducer.start {
            _ in
            self.keywordInput.rightView = self.loadingIndicator
            self.keywordInput.rightViewMode = .Always
            self.loadingIndicator.startAnimating()
        }
        
        throttledKeywordSignalProducer |> map {
            GitHubClient.searchUser($0 as! String)
        }
        |> flatten(FlattenStrategy.Concat)
        |> start {
            self.loadingIndicator.stopAnimating()
            self.keywordInput.rightViewMode = .Never
            self.viewModel.users = $0
        }
        
        viewModel.prop_users.producer |> start {
            _ in
            self.userListView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count:Int = self.viewModel.users?.count {
            return count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ViewController.REUSE_ID) as! UserCell
        
        if let user = viewModel.users?[indexPath.item] {
            cell.userNameLabel.text = user.login
            let url = NSURL(string: user.avatar_url)
            cell.imageView?.sd_setImageWithURL(url, placeholderImage: defaultProfileImage)
        }
        
        return cell
    }
}

