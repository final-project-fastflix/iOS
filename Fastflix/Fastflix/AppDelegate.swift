//
//  AppDelegate.swift
//  Fastflix
//
//  Created by hyeoktae kwon on 2019/07/10.
//  Copyright © 2019 hyeoktae kwon. All rights reserved.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  static var instance: AppDelegate {
    return (UIApplication.shared.delegate as! AppDelegate)
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    checkLoginState()
    return true
  }
  
  func checkLoginState() {
    
    // 유저디폴트에 저장되어있는 "token"값 확인
    let token = UserDefaults.standard.string(forKey: "token")
    
    
    // 1) "token"없을때 안내화면 -> 로그인화면
    let beforeLoginNavi = UINavigationController(rootViewController: BeforeLoginVC())
//    beforeLoginNavi.viewControllers = []
    
    // 2) "token"값 있을때 (로그인없이)홈화면
    let tabBar = MainTabBarController()
    
    
    // "token"값 nil일때는 1)안내화면으로 / nil이 아닐때는 2) 홈화면으로
    let rootVC = token == nil ? beforeLoginNavi : tabBar
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.backgroundColor = .clear
    window?.rootViewController = rootVC
    
    window?.makeKeyAndVisible()
    
    topPadding = rootVC.view.safeAreaInsets.top
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

