//
//  AppDelegate.swift
//  final_Movies
//
//  Created by Godfather on 12/23/16.
//  Copyright © 2016 Godfather. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        let flowLayout = UICollectionViewFlowLayout()
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController(collectionViewLayout: flowLayout))
        application.statusBarStyle = .lightContent
        UINavigationBar.appearance().barTintColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)

        let statusBarBackgroundView = UIView()
        statusBarBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        statusBarBackgroundView.backgroundColor = UIColor(red: 77/255, green: 77/255, blue: 77/255, alpha: 1)
        window?.addSubview(statusBarBackgroundView)
        window?.addConstraintsWithVSF(formatString: "H:|[v0]|", views: statusBarBackgroundView)
        window?.addConstraintsWithVSF(formatString: "V:|[v0(20)]", views: statusBarBackgroundView)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

