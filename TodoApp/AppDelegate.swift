//
//  AppDelegate.swift
//  TodoApp
//
//  Created by 김진혁 on 2023/04/03.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    //MARK: - 앱이 로드될 떄 호출되는 곳
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //realm 의 파일 위치 확인 코드
        print(Realm.Configuration.defaultConfiguration.fileURL)
        //그 후 command Shift G를 눌러 해당 위치를 입력하면 바로 이동 가능
        
        
        
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
