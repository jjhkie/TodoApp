//
//  AppDelegate.swift
//  TodoApp
//
//  Created by 김진혁 on 2023/04/03.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    //MARK: - 앱이 로드될 떄 호출되는 곳
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //USerDefaults plist 파일 저장 위치 
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        print(#function)
        return true
    }

    // MARK: UISceneSession Lifecycle
//MARK: - 새로운 scene/window를 제공하려고 할 때 불리는 메소드
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

