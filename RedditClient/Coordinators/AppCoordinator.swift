//
//  AppCoordinator.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    enum EntryPoint {
        case topFeed
    }
    
    required init(with router: Routable, api: API) {
        super.init(with: router, api: api)
    }
    
    private var entryPoint: EntryPoint {
        return .topFeed
    }
    
    override func start() {
        switch entryPoint {
        case .topFeed: runTopFeed()
        }
    }
}

extension AppCoordinator {
    
    private func runTopFeed() {
        let coordinator = create(TopFeedCoordinator.self)
        coordinator.start()
        
        let routerOptions = RouterOptions.init(operation: .root, animated: true, isNavigationBarHidden: true)
        
        router.show(coordinator, options: routerOptions) { [weak self, weak coordinator] in
            coordinator?.router.hide(options: RouterOptions.init(operation: .present, animated: false, isNavigationBarHidden: false))
            self?.removeChild(coordinator)
        }
    }
    
}
