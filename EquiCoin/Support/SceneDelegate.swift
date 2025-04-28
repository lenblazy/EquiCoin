//
//  SceneDelegate.swift
//  EquiCoin
//
//  Created by Lennox Mwabonje on 27/04/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene                       = (scene as? UIWindowScene) else { return }
        window                                      = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene                         = windowScene
                        
        let apiManager: ApiManager                  = UrlSessionApiManager()
        let datasource: CoinsDatasource             = ApiCoinsDatasource(apiManager: apiManager)
        let repository: CoinsRepository             = CoinsRepositoryImpl(datasource: datasource)
        let rootVC: UIViewController                = ECTabBarController(repository: repository)
        let navController: UIViewController         = UINavigationController(rootViewController: rootVC)
            
        window?.rootViewController                  = navController
        window?.makeKeyAndVisible()
        UINavigationBar.appearance().tintColor      = .systemGreen
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
       
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }


}

