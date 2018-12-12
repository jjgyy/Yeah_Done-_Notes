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
        Bundle.main.onLanguage()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    

}


class BundleEx: Bundle {
    
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        if let bundle = getUserSettingBundle() {
            return bundle.localizedString(forKey: key, value: value, table: tableName)
        } else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
    }
    
    func getUserSettingBundle() -> Bundle? {
        guard let userLanguageTableIndex = UserDefaults.standard.string(forKey: "userLanguageTableIndex") else {
            print("userLanguageTableIndex value in UserDefaults is nil")
            if let systemLanguage = Bundle.main.preferredLocalizations.first {
                for index in 0..<AllLanguage.allLanguages.count {
                    if AllLanguage.allLanguages[index].fileName == systemLanguage {
                        UserDefaults.standard.set(String(index), forKey: "userLanguageTableIndex")
                        print("set userLanguage value with system language because it is in the AllLanguage")
                        break
                    }
                }
            }
            return nil
        }
        
        guard let tableIndex = Int(userLanguageTableIndex) else {
            print("couldn't make userLanguageTableIndex:String to tableIndex:Int")
            return nil
        }
        
        guard let languageBundlePath = Bundle.main.path(forResource: AllLanguage.allLanguages[tableIndex].fileName, ofType: "lproj") else {
            print("couldn't find language bundle path \(AllLanguage.allLanguages[tableIndex].fileName)")
            return nil
        }
        
        guard let languageBundle = Bundle.init(path: languageBundlePath) else {
            print("couldn't init language bundle with bundle path \(languageBundlePath)")
            return nil
        }
        
        return languageBundle
    }
    
}

extension Bundle {
    
    func onLanguage(){
        object_setClass(Bundle.main, BundleEx.self)
    }
    
}

