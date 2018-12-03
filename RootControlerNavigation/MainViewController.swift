//
//  MainViewController.swift
//  RootControlerNavigation
//
//  Created by David on 17/10/2018.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray
        title = "Main Screen"
        
        let logoutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logout))
        navigationItem.setLeftBarButton(logoutButton, animated: true)
        
        let activityButton = UIBarButtonItem(title: "Activity", style: .plain, target: self, action: #selector(showActivityScreen))
        navigationItem.setRightBarButton(activityButton, animated: true)
    }
    
    @objc
    private func logout() {
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        AppDelegate.shared.rootViewController.switchToLogin()
    }
    
    @objc
    func showActivityScreen(animated: Bool = true) {
        let activityViewController = ActivityViewController()
        navigationController?.pushViewController(activityViewController, animated: animated)
    }
}
