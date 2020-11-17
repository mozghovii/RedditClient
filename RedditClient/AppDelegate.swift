//
//  AppDelegate.swift
//  RedditClient
//
//  Created by Sergey Mozgovoy on 17.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    private lazy var navigationController = NavigationViewController(nibName: nil, bundle: nil)

    private lazy var coordinator: AppCoordinator = {
        let router = Router(presenter: navigationController)
        
        // api
        let apiConfiguration = AppAPIConfiguration()
        let api = AppAPI(with: apiConfiguration)
        
        let coordinator = AppCoordinator(with: router, api: api)
        return coordinator
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // app coordinator
        coordinator.start()
        
        // create a basic UIWindow and activate it
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

