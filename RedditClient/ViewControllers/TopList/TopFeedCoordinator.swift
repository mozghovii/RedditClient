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
        viewController.viewModel.onImagePressed = { [weak self] imageURL in
            self?.showImageViewer(by: imageURL)
        }
    }
}

extension TopFeedCoordinator {
    
    private func showImageViewer(by imageURL: String) {
        let coordinator = create(ImageViewerCoordinator.self)
        coordinator.imageURL = imageURL
        coordinator.start()
        
        coordinator.successAction = { [weak self] in
            self?.router.hide(options: RouterOptions.pushDefault)
        }
        
        router.show(coordinator, options: RouterOptions.pushDefault) { [weak self, weak coordinator] in
            self?.removeChild(coordinator)
        }
    }
}
