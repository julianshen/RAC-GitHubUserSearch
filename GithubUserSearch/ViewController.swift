//
//  ViewController.swift
//  GithubUserSearch
//
//  Created by Julian Shen on 2015/5/7.
//  Copyright (c) 2015年 Julian Shen. All rights reserved.
//

import UIKit
import ReactiveCocoa
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let viewModel: UserSearchViewModel = UserSearchViewModel()
    @IBOutlet weak var keywordInput: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.prop_keyword <~ keywordInput.rac_textSignal().toSignalProducer() |> catch {
            error in
            return SignalProducer<AnyObject?, NoError>(value:"")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("user") as! UITableViewCell
        
        return cell
    }
}

