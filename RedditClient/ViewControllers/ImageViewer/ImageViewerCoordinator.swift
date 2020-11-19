//
//  ImageViewerCoordinator.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 19.11.2020.
//

import UIKit

class ImageViewerCoordinator: BaseCoordinator {
    
    var successAction: (() -> Void)?
    var imageURL: String?

    override func start() {
        let viewController = instantiate(ImageViewerViewController.self, from: .imageViewer)
        viewController.imageURL = imageURL
        viewController.successAction = { [weak self] in
            self?.successAction?()
        }
    }
}
