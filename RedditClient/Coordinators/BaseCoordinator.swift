//
//  BaseCoordinator.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

enum PresentOperation {
    case root
    case push
    case present
}

class BaseCoordinator: NSObject, Coordinator {
    
    var router: Routable
    let api: API
    var childCoordinators: [BaseCoordinator] = []
    var viewController: UIViewController?
    
    required init(with router: Routable, api: API) {
        self.router = router
        self.api = api
        
        super.init()
        
        self.router.delegate = self
    }
    
    func start() {
        assertionFailure("Please override this method in subclass")
    }
    
    func viewControllerDidShow() {}
    
    func instantiate<T>(_ viewControllerType: T.Type, from storyboard: Storyboard) -> T where T: UIViewController {
        let instantiatedViewController = viewControllerType.instantiate(fromStoryboardType: storyboard)
        viewController = instantiatedViewController
        
        return instantiatedViewController
    }
    
    func instantiateRouter<N, V>(_ navigationControllerType: N.Type, _ viewControllerType: V.Type, from storyboard: Storyboard) -> V where N: UINavigationController, V: UIViewController {
        let navigationController = navigationControllerType.instantiate(fromStoryboardType: storyboard)
        viewController = navigationController
        
        router = Router(presenter: navigationController)
        
        guard let viewController = navigationController.viewControllers.first as? V else {
            fatalError("ViewController is not \(viewControllerType) class")
        }
        
        return viewController
    }
    
    func toPresentable() -> UIViewController {
        guard let viewController = viewController else {
            fatalError("ViewController did not instantiated")
        }
        
        return viewController
    }
    
}

extension BaseCoordinator {
    
    func addChild(_ coordinator: BaseCoordinator) {
        if childCoordinators.filter({ $0 === coordinator }).isEmpty {
            childCoordinators.append(coordinator)
        }
    }
    
    func removeChild(_ coordinator: BaseCoordinator?) {
        guard childCoordinators.isEmpty == false,
            let coordinator = coordinator else {
                return
        }
        
        for (index, child) in childCoordinators.enumerated() where child === coordinator {
            childCoordinators.remove(at: index)
        }
    }
    
    func create<T: BaseCoordinator>(_ coordinatorType: T.Type) -> T {
        let coordinator = coordinatorType.init(with: router, api: api)
        addChild(coordinator)
        
        return coordinator
    }
    
}

extension BaseCoordinator: RoutableDelegate {
    
    func didShowViewController(_ viewController: UIViewController) {
        viewControllerDidShow()
    }
    
}
