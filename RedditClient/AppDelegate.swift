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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // create a basic UIWindow and activate it
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        test()
        return true
    }
    
    func test() {
        let apiConfiguration = AppAPIConfiguration()
        let api = AppAPI(with: apiConfiguration)
        let request = TestRequest()
        api.send(request) { [weak self] result in
            switch result {
            case .success:
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }

}

