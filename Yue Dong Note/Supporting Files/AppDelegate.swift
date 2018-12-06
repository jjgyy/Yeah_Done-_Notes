//
//  AppDelegate.swift
//  Yue Dong Note
//
//  Created by Apple on 2018/12/4.
//  Copyright © 2018 Young. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        saveDragNoteViewControllerIfRoot()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveDragNoteViewControllerIfRoot()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveDragNoteViewControllerIfRoot()
    }
    
    func saveDragNoteViewControllerIfRoot() {
        if window?.rootViewController is DragNoteViewController {
            let dragNoteViewController = (window?.rootViewController as! DragNoteViewController)
            dragNoteViewController.saveNoteWall()
            dragNoteViewController.saveTheme()
        }
    }


}

