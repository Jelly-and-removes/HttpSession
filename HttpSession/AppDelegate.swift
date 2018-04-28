//
//  AppDelegate.swift
//  HttpRequest
//
//  Created by Shichimitoucarashi on 2018/04/22.
//  Copyright © 2018年 keisuke yamagishi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        TwitterKey.shared.api.key = "NNKAREvWGCn7Riw02gcOYXSVP"
        TwitterKey.shared.api.secret = "pxA18XddLaEvDgonl0ptMBKt54oFCW4GK8ZyPGvbYTitBvH3kM"

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
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        if(url.absoluteString.hasPrefix("httprequest://")){
            let splitPrefix: String = url.absoluteString.replacingOccurrences(of: "httprequest://success?", with: "")
            Twitter().access(token: splitPrefix, success: { (twitter) in
                print (twitter)
            }, failuer: { (error,responce)  in
                print ("Error: \(error) responce: \(responce)")
            })
//            TwitterAuth.requestToken(token: splitPrefix, completion: { (twitter, data, responce, error) in
//                print (twitter!)
//            })
        }
        return true
    }
}
