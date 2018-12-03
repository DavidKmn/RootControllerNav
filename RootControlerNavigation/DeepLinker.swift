//
//  DeepLinker.swift
//  RootControlerNavigation
//
//  Created by David on 17/10/2018.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

let Deeplinker = DeepLinkManager()
class DeepLinkManager {
    fileprivate init() {}
    
    private var deeplinkType: DeeplinkType?
    
    @discardableResult
    func handleShortcut(item: UIApplicationShortcutItem) -> Bool {
        deeplinkType = ShortcutParser.shared.handleShortcut(item)
        return deeplinkType != nil
    }
    
    // check existing deepling and perform action
    func checkDeepLink() {
        AppDelegate.shared.rootViewController.deepLink = deeplinkType
        
        // reset deeplink after handling
        self.deeplinkType = nil
}
}
