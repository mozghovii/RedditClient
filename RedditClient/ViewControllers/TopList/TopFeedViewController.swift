//
//  TopListViewController.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

class TopFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TopFeedViewModel = TopFeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpTableView()
        
        viewModel.reload = { [weak self] in
            self?.reloadTableView()
        }
        // Do any additional setup after loading the view.
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    private func setUpTableView() {
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
    }

}
