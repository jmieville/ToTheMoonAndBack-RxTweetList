//
//  AppDelegate.swift
//  RxTweetList
//
//  Created by Jean-Marc Kampol Mieville on 4/30/2560 BE.
//  Copyright © 2560 Jean-Marc Kampol Mieville. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let navigator = Navigator()
    
    let account = TwitterAccount().default
    let list = (username: "icanzilb", slug: "RxSwift")
    let testing = NSClassFromString("XCTest") != nil
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if !testing {
            let feedNavigation = window!.rootViewController! as! UINavigationController
            navigator.show(segue: .listTimeline(account, list), sender: feedNavigation)
        }
        return true
    }
}

