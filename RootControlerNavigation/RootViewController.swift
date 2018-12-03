//
//  ViewController.swift
//  RootControlerNavigation
//
//  Created by David on 17/10/2018.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
    
    var deepLink: DeeplinkType? {
        didSet {
            handleDeepLink()
        }
    }
    
    private func handleDeepLink() {
        if let mainNavigationController = current as? MainNavigationController, let deeplink = deepLink {
            switch deeplink {
            case .activity:
                mainNavigationController.popToRootViewController(animated: false)
                (mainNavigationController.topViewController as? MainViewController)?.showActivityScreen()
            default:
                // handle any other types of Deeplinks here
                break
            }
            
            // reset the deeplink back no nil, so it will not be triggered more than once
            self.deepLink = nil
        }
    }
    
    private var current: UIViewController
    
    init() {
        self.current = SplashViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.willMove(toParent: self)
    }

    func showLoginScreen() {
        let new = UINavigationController(rootViewController: LoginViewController())
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.willMove(toParent: self)
        
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        
        current = new
    }
    
    func switchToMainScreen() {
        
        let mainVC = MainViewController()
        let mainScreen = MainNavigationController(rootViewController: mainVC)
        animateFadeTransition(to: mainScreen, completion: { [weak self] in
            guard let self = self else { return }
            self.handleDeepLink()
        })
        
    }
    
    func switchToLogin() {
        let loginVC = LoginViewController()
        let loginScreen = UINavigationController(rootViewController: loginVC)
        animateDismissalTransition(to: loginScreen)
    }
    
    func showActivityScreen() {
        let activityVC = ActivityViewController()
        let activityScreen = UINavigationController(rootViewController: activityVC)
        animateFadeTransition(to: activityScreen)
    }

    private func animateFadeTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.3, options: [.transitionCrossDissolve, .curveEaseOut], animations: ({ })) { (completed) in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }

    private func animateDismissalTransition(to new: UIViewController, completion: (() -> Void)? = nil) {
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.3, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { (completed) in
            self.current.removeFromParent()
            new.didMove(toParent: self)
            self.current = new
            completion?()
        }
    }
    
}


