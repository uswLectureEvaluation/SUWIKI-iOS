//
//  SceneDelegate.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2021/12/31.
//

import UIKit
import RealmSwift
import FirebaseDatabase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let uswFireDB = Database.database(url: "https://schedulecheck-4ece8-default-rtdb.firebaseio.com/").reference()
    
    
    var window: UIWindow?
    let realm = try! Realm()
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let userDB = realm.objects(userDB.self).count
        let courseDB = realm.objects(CourseData.self).count
        self.window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let tbc = self.window?.rootViewController as? UITabBarController {
            tbc.tabBar.tintColor = .green
        }
        
    
      
        /*
        let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as? loginController
        let nc = UINavigationController(rootViewController: vc!)
        self.window?.rootViewController = nc
        self.window?.makeKeyAndVisible()
        */
        
        
        uswFireDB.observe(.value) { snapshot in
            let fireBaseCnt = Int(snapshot.childrenCount)
            
            if courseDB == 0 || fireBaseCnt != courseDB{ // 나중에 수정되는 경우 발생 시 로직 수정 필요
                let vc = storyboard.instantiateViewController(withIdentifier: "lodVC") as? loadingView
                let nc = UINavigationController(rootViewController: vc!)
                self.window?.rootViewController = nc
                self.window?.makeKeyAndVisible() // 화면에 보여줌
            }
            else {
                print("else")
                let vc = storyboard.instantiateViewController(withIdentifier: "tapbarVC") as? tabBarController
                let nc = UINavigationController(rootViewController: vc!)
                self.window?.rootViewController = nc
                self.window?.makeKeyAndVisible()
            }
            /*
            else {
                let vc = storyboard.instantiateViewController(withIdentifier: "loginVC") as? loginController
                let nc = UINavigationController(rootViewController: vc!)
                self.window?.rootViewController = nc
                self.window?.makeKeyAndVisible()
            }
             */
            /*
             else {
                 if userDB == 0{
                     let vc = storyboard.instantiateViewController(withIdentifier: "firstVC") as? firstSceneCheck
                     let nc = UINavigationController(rootViewController: vc!)
                     self.window?.rootViewController = nc
                     self.window?.makeKeyAndVisible() // 화면에 보여줌
                 } else{
                     let vc = storyboard.instantiateViewController(withIdentifier: "showVC") as? showTimeTable
                     let nc = UINavigationController(rootViewController: vc!)
                     self.window?.rootViewController = nc
                     self.window?.makeKeyAndVisible()
                 }
             }
            */
            
        }
        
         
        
       
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}




