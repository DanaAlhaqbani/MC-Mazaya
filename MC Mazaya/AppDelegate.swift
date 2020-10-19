//
//  AppDelegate.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 29/10/1441 AH.
//  Copyright © 1441 MC. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let navigationBarAppearace = UINavigationBar.appearance()
//        let green = UIColor(rgb: 0x38a089)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: "STC", size: 20)!]
        let labelAppearance = UILabel.appearance()
        navigationBarAppearace.semanticContentAttribute = .forceRightToLeft
        navigationBarAppearace.titleTextAttributes = textAttributes
        navigationBarAppearace.barTintColor = UIColor(rgb: 0x1C9A8A)
        navigationBarAppearace.tintColor = .white
        labelAppearance.substituteFontName = "STC"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
        UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
        UILabel.appearance(whenContainedInInstancesOf: [UIButton.self]).font = UIFont(name: "STC", size: 25)
        UIButton.appearance().layer.cornerRadius = 20
        UIButton.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = .white
        UIButton.appearance(whenContainedInInstancesOf: [UIButton.self]).tintColor = .white
        UIButton.appearance().tintColor = .white
        IQKeyboardManager.shared.enable = true
    
        return true
    }

    // MARK: UISceneSession Lifecycle

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

