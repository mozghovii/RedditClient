//
//  TopListViewController.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

final class TopFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TopFeedViewModel = TopFeedViewModel()
    private var refreshControl = UIRefreshControl()

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
            guard self?.refreshControl.isRefreshing ?? false else { return }
            self?.refreshControl.endRefreshing()
        }
    }
    
    private func setUpTableView() {
        tableView?.dataSource = viewModel
        tableView?.delegate = viewModel
        tableView?.prefetchDataSource = viewModel
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(viewModel, action: #selector(viewModel.refreshData), for: UIControl.Event.valueChanged)
    }

}
