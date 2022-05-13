//
//  SceneDelegate.swift
//  Rolodex
//
//  Created by Mat Schmid on 2022-05-09.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: scene)
		
		let controller = EmployeeListViewController(endpoint: .production)
		let navigationController = UINavigationController(rootViewController: controller)
		navigationController.navigationBar.prefersLargeTitles = true
		
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
		
		self.window = window
	}
	
	// MARK: UIWindowSceneDelegate
	func sceneDidDisconnect(_ scene: UIScene) {}
	func sceneDidBecomeActive(_ scene: UIScene) {}
	func sceneWillResignActive(_ scene: UIScene) {}
	func sceneWillEnterForeground(_ scene: UIScene) {}
	func sceneDidEnterBackground(_ scene: UIScene) {}
}

