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
        let _ = AppEnvironment()
        let appState = AppState()
        guard (scene is UIWindowScene) else { return }
        let lectureView = DIContainer.shared.resolve(type: LectureEvaluationHomeView.self).environmentObject(appState)
//        let lectureDetailView = LectureEvaluationDetailView()
        let login = LoginView()
        let mainViewController = UIHostingController(rootView: lectureView)
        window?.rootViewController = mainViewController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

}
