//
//  SceneDelegate.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/05/23.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        let appState = AppState()
        guard (scene is UIWindowScene) else { return }
        let mainViewController = UIHostingController(rootView: TabBarView(appState: appState))
        mainViewController.view.backgroundColor = .systemGray6
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }

    //        let lectureDetailView = LectureEvaluationDetailView()
    //        let login = LoginView()

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}
