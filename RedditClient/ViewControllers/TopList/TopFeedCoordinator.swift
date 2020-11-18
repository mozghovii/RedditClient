//
//  TopListCoordinator.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

class TopFeedCoordinator: BaseCoordinator {
    override func start() {
        let viewController = instantiate(TopFeedViewController.self, from: .topFeed)
        viewController.viewModel.api = api
    }
}
